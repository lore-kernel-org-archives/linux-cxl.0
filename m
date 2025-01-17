Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B641F76BD;
	Fri, 17 Jan 2025 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103309; cv=fail; b=MKB+xONRgzYDIx8+/GOlfn/PMWuD2GxfYckZn0gpl9MYN9WZ+lnOI03XauoHFokRKfiM7u6DvK6FMm/xkChHVeCvS0UYLEPVXenqgxYFJQ+YEk6LUnY/360rEkKIqSMiDAWs2YbnRrup4AkVV8Ku8dCvJB0zVctm/Z2SEA8Gw5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103309; c=relaxed/simple;
	bh=CH27j1pRoKTYLNb47ovliBAi4BQBjjxuVC0AAV4KLQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p4J0mBLT9rmEDOTjFbRmBI5T7pJlViYV/ouEk0yWFLvSbB/KIWYu41GAxx5B1Rq7v04LGv5x8Vs4hXIk3o6Vsrl/ZONJ14L2F5z6l36ZJoxMJIF2Fw8kprL57aXCjaceoRyFfjhzuU9hS9ep7/0MF6ZDOuosVz72TxBzOu4SQiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N9w0swnR; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N9w0swnR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgFHhZKS/4oKhZAZOVlevDqi+DErzhF8JmPGMe4UsFivu6DAsYL+ZgyRXwPAu/jLFnZZ9NuLH7GPTUFhnSo96HiKOIJihVm6diXPwWyV0Oc9m9Rg7HtLNccvWkgDfp0gwHUPGhqjsn5H3bk/N8KfBsTu8gGesV7OPAjjAO4Qdb486luK5Jopx5nFj/8q/WPyMTuGqOS2i7ZVmmWXwNxdAJu4tPZTfTysVFJvaYOqZNWQGnInVPyeJYrjHg0xyMF0eXupZ9DBtzTY1clIeBJEs93/DvHiX/3RSWRJXY9bd850p3S0AoSqhYwgv5ibOBESSe50KPM9OVT5/ZbojeFoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypiYu+3OZh74IDh33FN+LC9SlJweEU+HnmUNJtlqFJM=;
 b=lAYNWdH+G4czsvghbPuwKSuaPQDOfFBAHzQtQf7M2dej9d0I0xZ2pUv0yCJDYxVA3qFQ75zWvVK+j8pjJMw81eBfD9D4P1OHrEbfFcwvpFOtxpHdcv4LogHF5hDExXPA8HGTYDgf3Vc5Hr2osE+boAxH/TS9Fu7hSPEOhh6ErzF0d9My1KMTwm6WjRIs1yFtp8gEHpPWmGhR6KxDrsiDc0uZHp54lLbEG70e+hk+zTDFfiqrdZVo3qxpWBRKs4D0ZS1s+dg2MPGRphvpEWY1E3dPdsUjN/yXCWMfz8wfLuwIkCxxY+Dr8mDjOb4SvqqzzRbSOiUt/pQWWASEeT8Amw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypiYu+3OZh74IDh33FN+LC9SlJweEU+HnmUNJtlqFJM=;
 b=N9w0swnRVz59EQ2xuD+Lih6Hx22L1/ZYE9B4Vq4bXmIPpkp8I0sHBmPSvp2bSUy+4vLeuLKxoXlb7VayZ4bHBfB/Cfab04qNj0rFucFnF/1FpCMHq/tuCLM4Ls2C/juH8zKK49R7PU43kWT8Tq8EcTRnxDFHR16RoLYqkiKtFzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 08:41:46 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 08:41:45 +0000
Date: Fri, 17 Jan 2025 09:41:33 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z4oXveNwQn9yPajZ@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
 <Z4Gjw5LGTppFfuAC@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Gjw5LGTppFfuAC@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR0P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a15784-47b0-47b9-c4cf-08dd36d2c666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tRgALEm1E826oQtUe8yFLynZ9BdM6dAAbpC1zNk9+vgVpecZ0jgerIDSg5UK?=
 =?us-ascii?Q?UpG4buwKcFm0yIQ1Ig3pcTnYdCZw26UrqEL89CKCStWCIskC/c5uTOIp/8V0?=
 =?us-ascii?Q?YFXrcuy7o1KDrF0Q3QqepFImNib1Dr9RGwOYT1/o4NVcB3cHD6cmmiMDbxiH?=
 =?us-ascii?Q?CaC2ltN6H/OKeSXauBaLitTFJ7zfh4LVUkVnu+k8b7cND59UpxhontP5t+Id?=
 =?us-ascii?Q?L7ZZXLG1GEZaeB6sOScybvJZ8KItT5qm0VLHidzFsCoOAPR84O3fzAhBM8Ln?=
 =?us-ascii?Q?dNUA5oz27wKRqPXJbOoEyuXotqrAj/KySD8OFSPtOwyVMCYgZHvJM3l+XDc6?=
 =?us-ascii?Q?wLUfesyUspvkomB8w4rBozwILD7zDibKFzOS6gtE0lsfiK8Z79b6sD+ZtWpm?=
 =?us-ascii?Q?N6kEHq1x2mthGbL+6Yx/jjI1hypFs/niuG2ywdgJRY+yGeiMNk6n1YpARt0Z?=
 =?us-ascii?Q?SSbzGVPkFKG6PowffcuF/Mwb70dgnN5ma7qKbxHLKB+fDx0yLicm3JwTOWwQ?=
 =?us-ascii?Q?pUJ1bZYCsZxnpSG9OXZThIDzynXUUaZJxYHNTXAEUJQcGA4Ef0g21HcA2p52?=
 =?us-ascii?Q?ukulXhuGLkv50T4D12fRSx5MGZoTITUWdKdBuNGS4dxpYMqPM8hqmSHbnf4m?=
 =?us-ascii?Q?kVo7Led8MpJDySV7NoyHJaRy22INdjRR3boizlwHWwhzLpK0ZZp0z5b6MfNn?=
 =?us-ascii?Q?JCM/0+j7OTurI1tT199AImpg42RL8ndg7mRYojEHC/tMy1ZExvkHfWcOWu0k?=
 =?us-ascii?Q?z/Oh3wj6D4bJkLv5lIZupjfmaLOE29VcQT8gQ67vgag6lwo/IvPdidd6GD8J?=
 =?us-ascii?Q?e1xvH0VWE69AcDMbYfKRJWObr0qVF4V0nPbMcZYSqofI7KyJVH62rOPZOIrC?=
 =?us-ascii?Q?D/ajCE02D9GGsWzcFEeEfC2MxXylHRshh9raUjVWwbaUlhTk8iruhqDj+hQx?=
 =?us-ascii?Q?M0pgRdA1yNfP2BKWcA7OWe9JSwVyMA5H8ecJAmnRSBIdBsw0MsXZ+3lAaEpu?=
 =?us-ascii?Q?CLVZ05mMIjOv0iOsyewL06y6VZc1C6m5Oy370PC0u9KNNONUGt8jwX+MmKcS?=
 =?us-ascii?Q?QgVjMoOENLl3esqmdVUtt+DSzHp0k7BWhYsWYNOmpC/SoQqEYu7LzVz3bf7C?=
 =?us-ascii?Q?okfzdEvSZT+wuJuMGU95lNasGY0MqrHB6T0Rp63ZJNLFCqksn8pnaG0K08aA?=
 =?us-ascii?Q?1PoIe3pLJQiK6lBo78MtwkLmoAhP1xuTQ8iMcJFBTo3irO8RDaS9ih33UL81?=
 =?us-ascii?Q?vafb+9F0uuZ5mtW8nWkonzBPP8r59i0Qf7Tk8dZAwih5V4ctqME9ySaG0pdd?=
 =?us-ascii?Q?0g90JNALKwQkAkK6rBk/PdBvHeTyAttVtLTC/L40Yts5IkP0Ml1Wke9wgIr2?=
 =?us-ascii?Q?Xp5yaRr2XEoMP7OVX0Ef2DBb5bVZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e1ar7/EdryizRGepkiXqaN6eNtbHhYGIFramQW0i93kti3cEI1dNwMW6jkb6?=
 =?us-ascii?Q?+/EhURALg8d3DlgNPUMZKtehaueF996vP2NAoxtLnC+ejo2EhIqPX2ppXXZG?=
 =?us-ascii?Q?kdXU/MRxqz6o4iTrsNQZPeIETIoycNd180ufztUW931WR59R7us3wd2LbDVe?=
 =?us-ascii?Q?Lm5h1RRUEzJn8pQhYlLujlDnauRKfTiQFgCA4avWAm5K1PKGQmz7N9PqBaSC?=
 =?us-ascii?Q?WP13XBz3Y5ME3DJMI2klhhPrtsjDGGRrfamJekrAjyK5K1h2yAZR9s5XnbD2?=
 =?us-ascii?Q?e00MQCkQ835QqobV+AxXxplUzFp0z8uN4uneMFMs7TZEcpEi1UhFUqoJ5/n8?=
 =?us-ascii?Q?BJD6sPhftMyvVZrQQHbYvQri+3uBJoitpElYLiWdlUb3NnzypZ7T8fso0mHg?=
 =?us-ascii?Q?/00YS2cN1AmDPPeLL/6koysdHLZ4iNzn8chK/1d/Xv5a0ZUm/5rpDFMwz3/T?=
 =?us-ascii?Q?bWPy4sRet6pW4ehYMY5j1pNhwJfT2XM/ruGnJApFs+SJNRkaYRalwGle06+R?=
 =?us-ascii?Q?C7U3xBpy3lE/I6JkbBIVS/Lz1iGEDRLp7qiudUz8q/iwKajcl8zZul/VRjQf?=
 =?us-ascii?Q?TJcOopE3gieKtgamJaXePnzBTCdj/oESaYWmX+sgI/FVDQDLlP8R9biku845?=
 =?us-ascii?Q?wdGHH6qQC5IQmTgc2+3GZGbwk7GF7tfXMkL83J0sh3QfvDGkIzoZW6/xeKiu?=
 =?us-ascii?Q?5wg89styEx8X64O2MINVeLmPMqxdpGXV/E5/Cx2Oz6nCjA20QfvXAhrzSZbU?=
 =?us-ascii?Q?vS2Wv9ulZRkQPry9syxTccEL/FxJFYLN107Pio6YaAg5Uvf3RDn2Xr54qbZ/?=
 =?us-ascii?Q?8zkbR1hppW9myy8h2ZmMy/KptebId+SCUoF4UAxV4iqPDWErJSvhMm0xxUAa?=
 =?us-ascii?Q?MdzXcKTFRWeX8zHcnJUnjcQdgjRjbkOKdLeBhthfaYpQvYcjrOAltH54GW23?=
 =?us-ascii?Q?jeTl90TJiSemlHW/4ikYLd2I/KGyc91ewlycymSx4D267xVE8asGyAQET78a?=
 =?us-ascii?Q?6d6SpHoRgK6R5bOoe1YvGY1OH5iL+HYv7cCNVCM3bZDsP2r+G8uK3Zzmt4U3?=
 =?us-ascii?Q?iOGigAH5v/GPKsUjHCX+S5a8NYzQCZUEFB+eqbEck8HrjXJ8NPg74fkvDqzU?=
 =?us-ascii?Q?U+og9gTathBZIMT6xe88AkElbV6ncLvVN9hSVWazdNS8cgBb+GH5SsHobffv?=
 =?us-ascii?Q?PVOQhzRtHCOeq1+HdgVy0+6R1CasK0XQxOipX48J1RwjxhnLfOE2Lj49Ncgp?=
 =?us-ascii?Q?6+2CYomcNdy4T0sEjLTAZJ10URJBUjZbNH/WFUuBwlhhGTCPd3MOVkCLNQey?=
 =?us-ascii?Q?4GSyBvTdWXJ7kC0H39My9edzBd7Jdvue56YLbcV7+DsFNjxtiwuRn7666bqe?=
 =?us-ascii?Q?h/mP4XoS9BIU42+qFo2JTW4G2Afxf8qQg3Qersof4SMpoc8fWl3h7OQHv1Hf?=
 =?us-ascii?Q?GB0Qk8+aVucmZ5TsuJNxldIxfkk5SJMx/CFBNNr9sdzsea/v4puD1zGdKIOQ?=
 =?us-ascii?Q?ILpbOd7buLU228+VfHQoqZLwYyrump1G9c/IA91a05rDrLj6+LKQhqMVx0OH?=
 =?us-ascii?Q?B5wINVBKKY5qv55qD/i8f8qTUmKw5mPDf1KUg8vt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a15784-47b0-47b9-c4cf-08dd36d2c666
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 08:41:45.7354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPYvs2xEHDbrrQG67HPGCYubBkV5tsidgyY33RFi0no8fVFGG5+jDFY39A2wd2c8Jfv6msiCSxfT8EflVWobpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260

On 10.01.25 17:48:35, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:10:11PM +0100, Robert Richter wrote:
> > Add AMD platform specific Zen5 support for address translation.
> > 
> > Zen5 systems may be configured to use 'Normalized addresses'. Then,
> > CXL endpoints use their own physical address space and Host Physical
> > Addresses (HPAs) need address translation from the endpoint to its CXL
> > host bridge. The HPA of a CXL host bridge is equivalent to the System
> > Physical Address (SPA).
> > 
> 
> Just adding the note that I've tested this patch set for HPA==SPA and
> found it causes no regressions in my setup.

Thanks for testing HPA==SPA.

-Robert

> 
> Still working on testing the normalized address mode due to a few BIOS
> quirks I'm running up against.
> 
> ~Gregory
