Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F6A17A31E;
	Thu, 25 Jun 2026 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375057; cv=fail; b=stRAMjcEAO+R2XnCAzW8ffmO1xTq6Tfb2fpi96HYKE0dzPGOuZVmhYV8zrmxUnOiDYfEbEN37pqQ1xwmIACPbiZycXCe2Api44fg1MoAXFRuM/rnL8LpHWwFHNDsCNEjAEN6DcY60Q9h0e3quxagNCDEe5meb9SOTc71hRNeLy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375057; c=relaxed/simple;
	bh=IoGBy70MP6qjz7HhqcaUvPHwkzhEzjVY1ypGAqD6mX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rArRSzIvXzDS5rRMMcQaggr5A3/UnO84O/YdSICuJt+wecid5IOcWt1wGqtCX4TXFRfGcuJbdTY2/vESb2YBwSbzCBxEJLvjxoQhNoWGX42MvcAK3KkeMtw7Bo5PHNcNtOh8pdX3KGagEgBKb/ulLTCIDkiJOqp3EzXcG/QNHvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=phmJ23Ov; arc=fail smtp.client-ip=40.107.208.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="phmJ23Ov"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8MWWSefW2SrvtQQc2lwe+4QBPBT5pXaHY4gB6aGi5DJDbWT5Vcxlx4YGfcOcGBqB8m9Qp6VYYuA5djiEP7GNnfN8E1To1UbSBk9Y3Uh5WV5QAPoKR/M8w7SuZ0JPS6vzfSxxePbEXCQemJfkU+1T/6JHF+w0G60clPacRNbDQI0p+W37M6ikzt4fPoApqppKG+kclcNwjf297/IqefrLDpBTtYVtHZpQi4ZV2S43y1FgEMt+X/FN5HkEC5KmwoVjF7h5dT5GO4YJvo+VCNpMEcEBw+HLLaxFi7fdkiXyS/8Y5Z831x7SJwsUzbrc3KZwMCNiJ3sp1PtLGwnrYPiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgFmfOqrFSMaoe7AYX2xYzq6WQlcNwSFBHsMo3pTh38=;
 b=xQUGmTetT+cnZiIyPhInu0+L8nDF7DGCphdRJ9VrkWYKPitHSp4LrDxFVMNJE3WZ1IYQPLukiP9ARfg9GxWVRXkbD58iW0wFTTr69hXrB0euSlGwbjImbuX4SfDPz8X6mhXO5uBkhwOrFhBvF69EB8CqJowSxj3ikAK/q62RA0Tokb8Rkx/B3WJ+NnY8Q56ueymgu1fHo0EYm1h+Xj7Achqghy+2XxUbJpcno9L6g9f0hiCEDefNSi9ZfMeHER0hHRYc2Fk2euCPR1L6ckAweD3Tji0UQtn70LgQ0fM8XPGrc1JouwZakY1RWo0RYvM18PDEfH2/uipQkXyLf7XmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgFmfOqrFSMaoe7AYX2xYzq6WQlcNwSFBHsMo3pTh38=;
 b=phmJ23OvJwr8ENE08C9+Ovmdp/Bu8qjgbbM6PQu3nn9jSy8VDutMWp19WYYuI1YT8DLb9PwAjqQXA/T9IN7WZwflzFqoVg2vBX3uldLo2yjE626uVzmX84gYa7zEP4Y3HOTit2gFAX3cVrggUUobQsg7OoyJINCTwC811+Ky438Gt7eiElJPMqDyTSSsTHgpiL8cP7OgHohEHbBQ6rEd+Nxm6wRYJKphTZ3aA3m1hrPMwR2HpIlHAgONbzQJD41v13GPusjnSjx3NviePi85QY4Ah7mcVNU8F8o2m8q0iPZKalaV4hiLNAszVt+kUcrGUUAL8WTerka7HjrX65zv9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 08:10:50 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 08:10:50 +0000
Date: Thu, 25 Jun 2026 16:10:45 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Wei Hou <wei.hou@scaleflux.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dan Williams <djbw@kernel.org>, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	iweiny@kernel.org, ming.li@zohomail.com, linux-kernel@vger.kernel.org, 
	kobak@nvidia.com, kaihengf@nvidia.com, newtonl@nvidia.com, kristinc@nvidia.com, 
	mochs@nvidia.com, danwilliams@nvidia.com
Subject: Re: [PATCH] cxl/pci: Remove incorrect mbox.valid check in
 cxl_pci_type3_init_mailbox()
Message-ID: <ajzhsubot_PSYtHQ@MWDK4CY14F>
References: <20260618170356.25382-1-wei.hou@scaleflux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618170356.25382-1-wei.hou@scaleflux.com>
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2df539-a70e-4d48-4838-08ded29144be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|366016|376014|3023799007|56012099006|18002099003|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	HA8IFC5xWwhASgY8jJyq6j6d3NdyddvVjU7DZOVixbM5Z/8BbhHEcFyRJt4PJc961w7dCBtuuVEWG4rGjqw7nNNJQHeH5TgLILhb8UNdbgZiKAqpFCWYDHRo64ROPkevTVVOxM6ZTJ7AOWY4MfXwgyoC/vJ52COxNCTNDFZ5AsrD63HpNF74tMLsNdByciJ76qJfebU83nr+Ll77DP9KsCFKkLdyI3CQX605Xo21ocoeNyWuQYjmumVOMLkFN4iOtZ7qiqeYPYFyyMMoLTVM0eH8kxkN7T7Yi6RZXma34pzlYES7RCFmGSk3NHjjR0ElnRdcZPHmjSH+OMRJR4NF6znrZbi4i1jd3CWKLJjZQTq7aCDCaKTDou5xvm0lSWadb40FtXWz6cmJVal4ZqMxcAToOKGYvqH4cwrtJdvdewOqeEBHmQ8k9eG59XsPljtw4Tc9ATGZ35/TDAkO8MSF2X+fwJgLQ0IeOSYWXZ9oEvkZXzPeFYYzYU9k5MlhruMtekb9TWIHmjhFWOOBLMsvYoCxdNShoIrrVdgterXTeA4WYyVUsI478AEiZA9H3Mi3bW0KiG9frUaqEASXbH6DUKVGdWO9aMvMwgwGGx47vOughqfuzQB0GFYtnl6dj8vt8mMSR47zr4H+ofbkteFUYH/OKgYq8FK3f8VyeLkl1Hk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(366016)(376014)(3023799007)(56012099006)(18002099003)(22082099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ldiZwxiIIIXgKGvoeUgQW45xOc9IpuI+d0DXkANxi7qIndTQZaKjrfJXNlL?=
 =?us-ascii?Q?K9vIbIfnBCbwT76OBq4P01QwvgdLaNMlvlfcCOCF9452no9ssMq632Ih+RoJ?=
 =?us-ascii?Q?PNpAEja6OXN13TidBXVdpTvd3CXxzGBGHE3J6+PK5lmSE3ilAH986CQamlJL?=
 =?us-ascii?Q?EdlFTyy1W5QJ/6slcNdpsry66edrKFU4xzUm3Yw1I+6KEbs8QgDKyUpjAalc?=
 =?us-ascii?Q?ydQ9R/4Mw6GHhdsRPYsN6t01oNzezGdBTkTJ63K+ZEDWyvJBg9vZHXVwmw+Y?=
 =?us-ascii?Q?fd7pT8uk+hqIvYpQNitg+Jg/C+KiE/1UIXNGXNaW913ftzm0eh3ggiNir1xl?=
 =?us-ascii?Q?csLjDt/wcmwcNC6NLELtGWIUxdZICpWxglG3agYGfv2w65IPbGKH73SCdG4j?=
 =?us-ascii?Q?e16UwXC5y7sUgdz8mcde2p7HIVPcCS8z8SUKzvmAbDYFYVKLuQQprLY+arA4?=
 =?us-ascii?Q?QQSZ9XKfoaFIxjQ6RNSNFuzfIpfVSJ1SkWcbjGRAso4GYcPuxTRxzO4GThYa?=
 =?us-ascii?Q?zTbf/qWNcL/jKU3oWcWG8l0s/xQMVYNyeBR83yvQ/o871Tz/gf3/yEzGHXK6?=
 =?us-ascii?Q?gGz6IL0hvyVtMX+jagDtU0P2zri4PCTgjXLUHECcn0Y9lA4sFcflRAYmC3EW?=
 =?us-ascii?Q?Z/j4YN6tuOzjhSV0sRFqlNdCnOlZiBqoTR91/f+BycFAIiGwFPD6LvAO6SN9?=
 =?us-ascii?Q?cKmIe+IqqNCVaG5O18PGz9u0viXuri4vdi4RyDvARoKYzirWZ2lySjIEg/C7?=
 =?us-ascii?Q?QBDCOL4pa5YYCylYlTviaDsp+LpQ7qYJWXZZu4jZHV82YYL7H4uN2+cV8QNn?=
 =?us-ascii?Q?NTqLNzSoluVzyTlcoXLgF0MdXHGFQtSslW2zGsTAdlwV4C/MPmvyXRqOC9gp?=
 =?us-ascii?Q?47SNJ6GNcfriIWHivNK8MOA8j/TA0L7uARnDUNyW7M4fbCcRMlbT26ehp0NG?=
 =?us-ascii?Q?AKLkYjBahfMkj5unm1sl9N7H12QmkeXqr2ETwMO+38HkL575e+IgKB1UQCRW?=
 =?us-ascii?Q?NljMddMsspKIxRD7olOnZ69cOeNzRsisDl4O99oLec5CHX/1yz+V3/7TEnEM?=
 =?us-ascii?Q?oq9UVzt3nV/y0dHOfH01vb9hz/kYth90dnHpAfJ0RG4d/6w71PKBtRcAOzwk?=
 =?us-ascii?Q?1NkffV1T5OlcT1qCfRyFgIbhtBhbliRL03VeYuz9X9/qmb1FfpMNNaqPfxsR?=
 =?us-ascii?Q?XB3/nNgKg5LxUv/+HhXC4HSuI7Ipc/5BxxlH+eUMp2caRLbfVSyakp7ml+Nl?=
 =?us-ascii?Q?hVICKuChS0T4xoVBZkvSbZkZ5xiqmzZBnRhUiVGKn0EgKii8QzYQyzAaKteV?=
 =?us-ascii?Q?BmXoon15iHR5sFSCE1ydJeFbd2ELXtMAP7ls71ObfuNaNESnS5DbxAuBh9K2?=
 =?us-ascii?Q?xzEgNBwPqQA5Fgfu9OrrIf47NG6hkv1SRjTujz2SwDILSogZW3WIaZ1C1tJN?=
 =?us-ascii?Q?V6eRq75qL831TdwT+pkowXlx6z/uQHOSi0deM+yzV9NOs5n2c8hN7AYCJzt1?=
 =?us-ascii?Q?bn3HQf+xMAgLFBIPOMXEsi/5JKu2XkRoaLGD8yPjZ8D/LiVlmRk+QTmu76cc?=
 =?us-ascii?Q?Jxy/DlUiWMk6Pu8wpXhYICag1Ahf51JXFYq/6SgAJq5ORl/a/DX5vUrAOU3K?=
 =?us-ascii?Q?tXjofC2k2RFocwXPaQWScODwpSpRLvSe9olDtPc5EVBr+zT/7Qm0paXHt0/p?=
 =?us-ascii?Q?bIT29d/A28dO4vkkAOD72vVryH7F2d2Q+m2/pPYAWnlqH9vnObflHBloxjZk?=
 =?us-ascii?Q?Ibh3Nv/lMg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2df539-a70e-4d48-4838-08ded29144be
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:10:50.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXHOkMzGTti0T5oEbQvvj1D7ae8ZipaekMhbZv2Qc3BHsWSmav162XLr98lLou6rNDxyXzYK7Y4PFvoO73JSPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118

On Fri, Jun 19, 2026 at 01:03:56AM +0800, Wei Hou wrote:
> The driver's design intent is that missing or malformed component
> registers should not prevent mailbox initialization. cxl_pci_probe()
> already reflects this: the CXL_REGLOC_RBI_COMPONENT setup path only
> emits a dev_warn() and continues when component registers are absent,
> rather than returning an error.
> 
> The check 'if (!cxlds->reg_map.device_map.mbox.valid)' violates this
> intent and is also technically incorrect for two reasons:
> 
> 1. Wrong struct: the MEMDEV register block is enumerated into a local
>    variable 'map', not into 'cxlds->reg_map'. The device_map.mbox.valid
>    field inside cxlds->reg_map is never written by the MEMDEV probe and
>    will always read as zero regardless of actual hardware capability.
> 
> 2. Already validated: cxl_pci_setup_regs(CXL_REGLOC_RBI_MEMDEV) calls
>    cxl_probe_regs() which explicitly checks mbox.valid and returns
>    -ENXIO if the mailbox is absent. If that check passes, the mailbox is
>    guaranteed to be present by the time cxl_pci_type3_init_mailbox() is
>    called.
> 
> The value that the check actually reads is component_map.ras.valid,
> which aliases device_map.mbox.valid in the union. This is populated by
> the COMPONENT probe, not the MEMDEV probe. On devices where the
> component register BAR does not implement a CXL Component Capability
> Array (e.g. certain DCD devices), cxl_probe_component_regs() returns
> early leaving ras.valid=false. Through the union, this makes mbox.valid
> read as false, causing cxl_pci_type3_init_mailbox() to return -ENODEV
> (-19) even though the mailbox hardware is fully functional.
> 
> Remove the check. Mailbox presence has already been validated by
> cxl_pci_setup_regs(CXL_REGLOC_RBI_MEMDEV). The presence or absence of
> component registers is irrelevant to mailbox initialization.
> 
> Signed-off-by: Wei Hou <wei.hou@scaleflux.com>
> ---
>  drivers/cxl/pci.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bace662dc988..e44e5d209900 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -691,12 +691,6 @@ static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
>  {
>  	int rc;
>  
> -	/*
> -	 * Fail the init if there's no mailbox. For a type3 this is out of spec.
> -	 */
> -	if (!cxlds->reg_map.device_map.mbox.valid)
> -		return -ENODEV;
> -
>  	rc = cxl_mailbox_init(&cxlds->cxl_mbox, cxlds->dev);
>  	if (rc)
>  		return rc;
> -- 
> 2.24.1
> 
>

Btw,

You missed to sent this one to many people, I'll add them this time for you

--Richard 
