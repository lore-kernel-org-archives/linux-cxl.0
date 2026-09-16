Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5157E4BD362
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582769; cv=fail; b=hCUWlM/OigazFHj6XVD+MPgnrh970eGcmBX6Vyx/r2XFj9VjK6G0v11o4UVLX6yu3UbCJ7VDNipkVy0OWpNVlVrcuvqajEE/8HnbD4qGa4c+YWtSPDKOCtLCsxxH6inUq0hofCHWpOx5DW619WJ4N3GlLfZd5sli1PI3ImefhCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582769; c=relaxed/simple;
	bh=lGuT/AtRhCHsgtsaNvi2qilJCooTXBhD1t4ShEfWqdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YPoYNJfqWrwmiC7Uhf78V42hNz5jq68+TRoocnGmsrLA2wyNOcui+JtCun5Z0ETQm36/O3lLr+VSDXiz6hgpzIRfbBpr6wK1xH2Zt1GhnE2FhOI2iIipPcXhvNl9w//jGHxx9tXvqXcT2xcaNhiATQyTm/Um2xVv8MoTh2rjv+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NPTACgSd; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NPTACgSd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbapF+hkrwYb3CjF97TrvacUlMSPTXO0O1EphJsgPMmpQbMnN2u9OaiQqp5lRnP/sScwj8UnW2JcifQoksQfsjTw/Pd35gPcEpx2pXvAkXPjYrw+c6iQnzy8WFW7ZEiUS/5GzyvfVjBOnH2WC+ba1WTN6izeuWeN+CixqCTytD3Gi/tYD4rwvRDqynFvG9sqoVJQiinAQ5U57g4/7I8dNmU6/8sh/fjh28mwwR76dQAifaq/6QuZVOrAb+805Q2Q/D8zr8Hu1SIAaon5+lOREs3DaY0K0Yu68hvyNjQgsL+PDqXCcjWupDjXOhFB6tc3LTQfR4+0TfJ2bNGWe68hVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzxO7XPeYGt7dxDW4+5XgbPp4Gyiy6GrGqRsbrVbEpI=;
 b=nRF5sbOSXG7g+bt1VMskGRI81vCuh66iI95Rtyzpx/ARtzOdTRwB4R/WQ9E3nEfaK/iG7IWqYA8Pkt5T5PyCusrzs73pF41CgEg3Ms1SxmU5LVlyNWuwaWmD2el9dX4/+iEGnnSj0ZINFB3yDMDna+nHy9MRpVt7yo6WHbXwgyVD173GyYfk86+6A3p6BdNoVR+xBaNDszn0+S3uftzsE2NFM7Tmprblnm28i3KwhUzY4rUME7qXFQOgUCTRLoCqpkI1K5q4yRrjZ6I1wl4Lks20lJsANrNesJY6uqFumqbCc7vRNl3PyuDYiCcl0pSRJjRyjpVvUw6jo+DcajywBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzxO7XPeYGt7dxDW4+5XgbPp4Gyiy6GrGqRsbrVbEpI=;
 b=NPTACgSdxv0S97xdCXySw/OTp9XwYOTBssDQZDcCF8qepvwqaefwPkIbieAV+4h+B42sJ7m2+vH6MM6IUlD505QzKr6mQqrDR3nZ34tIE4SvLO1DHQCiDeB6wjLhetQhzjsvaVSOi7bMMn67y8ebSl+DNFMHqJi3NJK4Ip05ikQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Wed, 16 Sep
 2026 18:19:05 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 18:19:05 +0000
Date: Wed, 16 Sep 2026 20:19:01 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 0/7] cxl: Support mixed-granularity region interleaves
Message-ID: <aqrdldrW4T1H79NL@rric.localdomain>
References: <cover.1788475206.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788475206.git.alison.schofield@intel.com>
X-ClientProxiedBy: FR4P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::12) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: beb08d9d-00e9-4ea7-01bb-08df141efe1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|56012099006|6133799003|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HBzRKo0A1+HC5v9rR/hpIPkM0gH39mvekbAO7wsVbPWg153xdSXo6/UsXbxmIq7nVv7Zv3tzG3m3kx6p3ze1meRsByCMywAk3z+UczCDI3URmRe/8Wt1M0L3MdGsWT4RsYrs2g9hVkaakytnxlYg4qW7tmbDDtuNq9cMpzVTFYtuhdtRaiF3eXSdKv7zpMMQeTt6lgG+WnhIuhvJKPn1crxa/N9GNKoWfV9GtUXZlo6kUMvZD3f5KODhsPnqoyqkKRN3HwRNRmwmoBZrkVruDisK/zIxK4AfRxL1NX+bZ538pBhBJbh0M2oPqy9AEHrrz0Q1clX2WH/XkZGViqpxSvY7PBPpmKM9+6jtn6mEBBKHIz0et6BtF2533uRg7eGg7QR6z2toUxPxAnROKWku6G/dNdcD0qcn6Si1oo/BEMJ6ietrCTpG5G0NkhTE1E25e4m0EFrddAVqiTq7DH4Pq4nwO8I26iyhwMROl75Rs3Dli+9rArZC6cWUqkXk9ARd64xLN+KQFvVnWyZweBRLfBtm5HZSScw+9eYI4dGjLevxpIERsUHjc2cB3EOQw2FguYBa3UldbJvUhgCxNW6SEr9zacDZjaicJfIHS4TCvETrl5cEW1IQUSiB1amTdOCory3NmYyyA0yVG9H85X2xgQA2ee0OnBu/yX/x/N9JNbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(56012099006)(6133799003)(11063799006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o0nPMbNH32X9F0EDXZyAIwWMfoLrwsFyGn9nEB8CsFSoe4hPWfsOw9gYQKVG?=
 =?us-ascii?Q?ORUoELUVkOYhTCLnu7+qo8vfbpaCdG0U4V56/HFpWpK2R70IOiHFpEMuWPHI?=
 =?us-ascii?Q?7BVlmMFOQ/+3I5m3ywOBvLGEXSgzuXgSKu7xpCpGK+tMol7bhpMhcvOzsuGO?=
 =?us-ascii?Q?1nGe/0IlIMwPOhTQxVcJQBDtAqZRJcT3WcVG5Ouh2h/OgAUwgFxWlq/JntM5?=
 =?us-ascii?Q?jYJq1jb5vWDRWAtThuqdOisn+kCufoUkROBbYezOrLRo8TYQvAVPoU6ntj64?=
 =?us-ascii?Q?sYB3Wd2EY6VezIbyDuS2RCtodvykgV7dcsxTw/vk6stWeEOsIxgmkdF4WEA+?=
 =?us-ascii?Q?7bMPt3nlfzsK2FxkABNqGumTRrq3v/Wb96h+Y9DWS4Qkrjs3dG0FsPYEgsPv?=
 =?us-ascii?Q?r+SnHsuVeJDQI+I6qq75XF+MXThi2XTXdeZruKDDjbW8cBT1O00EQQsqMzUC?=
 =?us-ascii?Q?ptg2P22o/AhONl/vhr+v7PqVQHnZ3pGbObw3SUizF1YRDNl1x2ln8/02Kv0M?=
 =?us-ascii?Q?3FSUCr9RIN+T0VHGjUs4md757VGEl9Ubasz9HggC1ud3koU/lmmFH4IhvER/?=
 =?us-ascii?Q?tmIbrJUbjm40XZ9cmbd72T7QRgp1kWLEkYUQzZSnk1ntIB3wlEUCKQcyFSav?=
 =?us-ascii?Q?QZLxTCkuW01UKMRJlwbFNKYBznfwsA7OBq6dGnSa3BhXhBeYN778tUNF1d0P?=
 =?us-ascii?Q?tA3fmERJXOx3aNjaNTs8AyCOYjkkNEdrm7DyUOGVwtTthYg3n4ae5yGFApNX?=
 =?us-ascii?Q?0zp6SE8MalcL09iAWsWZGfSq0sQ+Oh1H23Ro9wrvznPoTD4/mL0kz/qV8UM6?=
 =?us-ascii?Q?8NdfxqMlVBzRPWE1uv3hIrm9fSbA3SZFJBp2ORiHR6YQX9vT1CfuPC9+UVrl?=
 =?us-ascii?Q?AjhXuvIxo2Ia6LxchmVyY5mV9+kZWMalvRx1HYsxu+RLxd6JluPaw81rWr+1?=
 =?us-ascii?Q?GHCuavIj7c8AZqz4qb9WQDQh9sZvo6Vrd2qjjerLYWlp9a0LFV1riSM8iMjA?=
 =?us-ascii?Q?FKJ8uCxva/5gmMBBW5nq/AgIQ9PnQfuthlBzWbMxoFdMDNF18luWNxJ5zATj?=
 =?us-ascii?Q?u8KcyrcR99VaCMRNut+Nrmv+vOj7Fml2GMB91TQxTfZSQS3sUgLL2slJjPAw?=
 =?us-ascii?Q?X5kzUsFx3EuN1c8djuiEXngu06tx7B+byVAE/KMhPMGSHrKryHhxo3ay42eJ?=
 =?us-ascii?Q?rxx+yVCqGmVU2M8PIhUAuDYCPbofla0M10Y/h7tc6WUIxskhsoQfbNkd/N14?=
 =?us-ascii?Q?L/oxcqOSE9hldrsXk6RqFWdGz9Q9LqmMi4PNfo4aREXHVi7HPZl/h/6xKpwy?=
 =?us-ascii?Q?/jxFItrBir4v0ehKXTHBo9Zr0inggcHriaRQ/HmXWy2lylfrAgq5CKLHbMht?=
 =?us-ascii?Q?8SKKWipv/se9BZ9QN6LbOhHxlXtnok/SGebfhEN7e29uvsopXA6Frz5wq2e5?=
 =?us-ascii?Q?RoBxmZoA54iKT2lr5gi+2MuuaWkNk5Ui9OkExmpkZ9Cl03ciwE0DmEqwRAg4?=
 =?us-ascii?Q?ZLPFyXzHIcn8JVBdwK736PREiLA3pHIY2792zbHrEcJhv2T6D+zB8pe0og+5?=
 =?us-ascii?Q?zToQMrl7SC36vWVhOu07IuFGLIL5KhFYj6knO6ZSOuu5q1BSGv40gl4iuphj?=
 =?us-ascii?Q?5dswkzHJkzgJ5Fo9eCcfkN0hgxtqE68WNXi9bgWEKBq2/ruNQWjcCXqpyqXa?=
 =?us-ascii?Q?vp1UukXXpk0aXYb98CKm4EoU9+bstew5WXNZ4/v0/qErlIWt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb08d9d-00e9-4ea7-01bb-08df141efe1c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:19:05.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3z1G0h134moEO6TUbhRzh4eoY1XVMf+jpMJBf1ERGkuWyLJTeLrenXkbdHEA5V/g9EBFf6/ARKlu3glGMMY1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952

On 03.09.26 16:23:42, Alison Schofield wrote:
> 
> JonathanC, I kept your tags on Patches 2,5.
> 
> RobertR, Same comment as in v4. I've dropped the Originally-by tags since the
> implementation no longer carries the selector-bit approach from your original
> patch. Let me know what authorship tags you'd like.

Fine with me.

The series is much simpler than v3 now. Though, I believe the selector
bit approach removes the limitations described, makes implemenation
easier and removes additional checks needed. Will take a look how that
could work and also give this series some testing.

Thanks for driving this.

-Robertx

> Alison Schofield (7):
>   Documentation/cxl: Describe mixed-granularity regions
>   cxl/region: Warn on user region position mismatch
>   cxl/region: Generalize endpoint position mapping
>   cxl/region: Name the interleave locals in cxl_port_setup_targets()
>   cxl/region: Support mixed-granularity auto regions
>   cxl/region: Support mixed-granularity user created regions
>   cxl/test: Add a topology to test mixed-granularity regions
> 
>  .../driver-api/cxl/linux/cxl-driver.rst       | 153 +++++++
>  drivers/cxl/core/region.c                     | 247 +++++++----
>  tools/testing/cxl/test/cxl.c                  | 410 +++++++++++++++++-
>  3 files changed, 698 insertions(+), 112 deletions(-)
> 
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> -- 
> 2.37.3
> 
