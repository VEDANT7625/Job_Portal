<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/JobProvider/JobProvider.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Job_Portal.JobProvider.Dashboard" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" crossorigin="anonymous">
    <style>
        .dashboard-card {
            background: linear-gradient(135deg, #c33764, #1d2671);
            color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .dashboard-card h4 {
            font-size: 1.2rem;
            margin-bottom: 10px;
        }

        .dashboard-card .count {
            font-size: 2.5rem;
            font-weight: bold;
        }

        @media (min-width: 768px) {
            .dashboard-card-container {
                display: flex;
                justify-content: space-around;
            }

            .dashboard-card {
                flex-basis: calc(25% - 15px);
                margin-bottom: 0;
            }
        }

        .chart-container {
            margin-top: 50px;
        }

        canvas {
            width: 100% !important;
            height: 300px !important;
        }
    </style>
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">
        <h2 class="mb-4">Dashboard</h2>

        <div class="dashboard-card-container">
            <div class="dashboard-card">
                <h4>Total Users</h4>
                <asp:Label ID="lblUsers" runat="server" CssClass="count">0</asp:Label>
            </div>

            <div class="dashboard-card">
                <h4>Total Jobs</h4>
                <asp:Label ID="lblJobs" runat="server" CssClass="count">0</asp:Label>
            </div>

            <div class="dashboard-card">
                <h4>Applied Jobs</h4>
                <asp:Label ID="lblAppliedCandidates" runat="server" CssClass="count">0</asp:Label>
            </div>

            <div class="dashboard-card">
                <h4>Contacted Users</h4>
                <asp:Label ID="lblContact" runat="server" CssClass="count">0</asp:Label>
            </div>
        </div>

        <!-- Hidden fields to pass chart data -->
        <asp:HiddenField ID="hfTotalJobs" runat="server" />
        <asp:HiddenField ID="hfAppliedJobs" runat="server" />
        <asp:HiddenField ID="hfJobPostsByMonth" runat="server" />

        <!-- Chart Section -->
        <div class="chart-container">
            <div class="row">
                <div class="col-md-6 mb-4">
                    <h4>Job Applications Overview</h4>
                    <canvas id="pieChart"></canvas>
                </div>
                <div class="col-md-6 mb-4">
                    <h4>Monthly Job Posts</h4>
                    <canvas id="barChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        window.onload = function () {
            // Get values from hidden fields
            const totalJobs = parseInt(document.getElementById('<%= hfTotalJobs.ClientID %>').value) || 0;
            const appliedJobs = parseInt(document.getElementById('<%= hfAppliedJobs.ClientID %>').value) || 0;
            const notAppliedJobs = totalJobs - appliedJobs;

            // PIE CHART: Applied vs Not Applied
            const pieCtx = document.getElementById('pieChart').getContext('2d');
            new Chart(pieCtx, {
                type: 'pie',
                data: {
                    labels: ['Applied Jobs', 'Not Applied Jobs'],
                    datasets: [{
                        data: [appliedJobs, notAppliedJobs > 0 ? notAppliedJobs : 0],
                        backgroundColor: ['#36A2EB', '#FF6384']
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });

            // BAR CHART: Jobs Posted by Month
            const chartData = JSON.parse(document.getElementById('<%= hfJobPostsByMonth.ClientID %>').value);
            const barCtx = document.getElementById('barChart').getContext('2d');
            new Chart(barCtx, {
                type: 'bar',
                data: {
                    labels: chartData.labels,
                    datasets: [{
                        label: 'Jobs Posted',
                        data: chartData.values,
                        backgroundColor: '#4BC0C0'
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1
                            }
                        }
                    }
                }
            });
        };
    </script>

</asp:Content>
