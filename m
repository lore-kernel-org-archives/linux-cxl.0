Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E921ADC3;
	Fri,  7 Mar 2025 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356413; cv=fail; b=MAkUIDhVMowhJ3uoI7baX5PdIB1fCnYK4BzS4KGDYfn0q6InegRbglLegih1EfgQJKfLr9Z/p5nKuvQA/tvt6Ybl28dcPKopfJpYJ+6WGYqAIU7YE9IoR0KYhkfi/l4maecLu+u4IaOs2OIZwkHCr63N3HKH2KJ3IVNK/UKY/jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356413; c=relaxed/simple;
	bh=JnKo7d3F8dEY49P37KBOMSOfvpwQx5y9JOfcyvr6OKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PtksrzCUmKVAWFG7WXJbVGbWa+m8zZ6JJA25UlULc53DOkM4FC5OJx39B5spkxBfDRvFiAM3dZ/PVICW61sBZanUfTsjy30EdOcDz9t/bNe/l3x07iWqxqPuL2bWABxTJkniSNcTOMStQ33N9ZcNm7z4nZjvc7EZiQVaKRqEsWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lo7+6Z2H; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lo7+6Z2H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mf8XbCG1VNrd7Y+6UAvpmxjzB+Bl7zy46AAXV5DVyQFo4FhPnMgEt3IG1RSOSm77IlBpQaWqGYJRLmBIiGRHQVYZTUgSUp7xQu1tK4PNg+keKDfpTUnaaUJJxLnlOqfdun/KAY7hvLnZOAGrfCL0dFTjwRPR0XhmSXCR33CDh9PmfgkJkCPjgl1i0Jibd0hgtBMZrgkeW6ZOPmVRxf8YoHuW8AsYChEwpE0XVB76zN9/p4wAUviaf2v1c9IYBOGUc1/+Cxqb9ZIiGAAUz7wFZbo61tvDm8rQn98ZZVypqJgKJ+dFkOy5o1AWl0nXtfbCX5eZ10d6paJXWLjF/NiVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vla9cO4JYJsTr7+qLfEkgoaFIXuSfavuBBP4NYgE+io=;
 b=FnhNbX2NVrq3iQH5boJjSE8LH0BqF5NpCRbcUrsxrrAlrqW6/iXPgnDmxXGOs8AC9nscyeXz6VcKd4wCY59X/4e1Ut8SmYBcjf91xLMm2uTkw1huCQ/oR6sbed5pC2afcccV+EX/uvmBHyOuRibt9AXz40md6TwoNvBTXcPg5tUccLZYmX8o8fZSI/jLznu559tHmtET68hhx4BgQvcztCbcUob4wCOq7NcWM1dW8gSat9CiZJu2vDx3W4uWh693SkRigLpvExLVH6KgfrvV7csiIfS/WIYQRVUSzs4e2BIpnyQjT3zgdF48hQpOgsYDyTMwAgSeuZfckpFECVuLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vla9cO4JYJsTr7+qLfEkgoaFIXuSfavuBBP4NYgE+io=;
 b=lo7+6Z2HF0h7ytpzCRrSFP6Ji6dyn95Pg51fn+QdukIjBuItA36K6m3fNztKIstMGiv5MpDi+a2oSwd3nMXl556lcNew2MaWi4FeKzF9Kw6IuP23KiJYBdVKL8pDHVvMo/bGjJWxo6dMcN2/SwC/Fi3/W8XyGx19mSgX/rAP45E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 14:06:48 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 14:06:48 +0000
Date: Fri, 7 Mar 2025 15:06:41 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH 0/2] cxl/pci: Inactive downstream port handling
Message-ID: <Z8r9cSxdhNyq4bvC@rric.localdomain>
References: <20250305100123.3077031-1-rrichter@amd.com>
 <67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR4P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: ed62030a-9ec9-4ae9-0741-08dd5d814cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2OmDtuEWKT4TsBysZcxnHCr60xQ9wMmrqrBf4FfywGjk4gJikbpGrko+b3ZJ?=
 =?us-ascii?Q?+qMR72b8hGaggE7dKtIy3Jtj6gcPKWsWjc9pRCK3kexxDVQtdxWXyzXAt6zN?=
 =?us-ascii?Q?d+TehTJxVCtAhfBHBUTK2afqU3WnMpbzzpKu8m5s4l772Te4qWuRHYEmk1D7?=
 =?us-ascii?Q?r/lub/4qd3XJr02Y8eXoc+PiPh/3u4RXbXXGKq7ZSCUZ4IwXpL0X1I0n9AHk?=
 =?us-ascii?Q?scZFVHFrdi3cq9Y2nMolv5tpQP49WOJAvxDNuJCK4htBr0D5j7FKzBe0zZui?=
 =?us-ascii?Q?FjKl3KqcN2/CRCrxl9apGf80sCHHn6l94cp9avlYOEPf0w159mkjfbj0RfUN?=
 =?us-ascii?Q?Dg/xNWsTxq1DWnzpIe7FslJx2VG1a7BJ99SUip5PEF5YFtq0U79rqEnpvxTX?=
 =?us-ascii?Q?F4d6vjqgmAypJ3nhcknFEkoKEFWHzolCr/rbq1y6/S+AKSRVrKK/Su4eXYeb?=
 =?us-ascii?Q?oY12ve49aJIemW51S7yoEDMfgeRpVxrJHRMxu963f5tvy/pDJOl9dpkt6ChA?=
 =?us-ascii?Q?0Ui6qB5OF88xNqN6b6v3iEztPQZS4BlWqWoytOPqMRKWscjLNc84Zhw8JlsK?=
 =?us-ascii?Q?EISoG0W+UuovscBSmByk9kkWbBGhi+45mHb1qZK82Ml/l3ggJr5tT4ZOlwBp?=
 =?us-ascii?Q?Pit9+jrpB5yveSNkatHnfvV4PgpCzlaX7CHGcl9GapUhYBanXizcQh4QaQlg?=
 =?us-ascii?Q?SN94Vo9mNUjutn3FnXxK+Ig0xP13zBe7hNqratn6//brVR8MXDbPlW+osbJn?=
 =?us-ascii?Q?Dtm8gzo1seCTL+nSX9H/u78DKm2GP0qY/Q8+uOS8EEAXCRnHCgeu7BV5KiMw?=
 =?us-ascii?Q?YQ28walW961O5VYmvxDO7st8sK5P0hMz8wnzWhUaZQLn0+k3MeTY0DnR9p2G?=
 =?us-ascii?Q?L2ZWz4O6hIeV5IwGOR0j4BTpSe23wCjElwhs+RqfF0Om9vuhrM5761H1WUdt?=
 =?us-ascii?Q?AC5hNZUXXqQ5DdVwW4AZAAdfTbyWoqYlowlWuLjeBO8PP5YmAbgshbN8W3Nn?=
 =?us-ascii?Q?U2RfC+NiPLLrO7DLxu2zUvBY7P2JglmplOE2sMv3Q36ggIeHE7EkMR4AvABP?=
 =?us-ascii?Q?1yIE33zS+3cvR2MIw7oPqEKHYQifRSh4Z5MyFt6fxx4js2xhQWkO96PyaNg/?=
 =?us-ascii?Q?gMxdCFgaoXGODBsT2qIUL3XCHFbdJk4mSNxHT1Jv9ni8nAmuDX5omkCBC679?=
 =?us-ascii?Q?dYbtN6ELJjGu3Q+Xqw2bfc8npfdCz793Oecdio3JTAj1fwk1IVfTNzRM3ZD+?=
 =?us-ascii?Q?6L2j99ufKS3sZ25POx7BZ08Fl46LSYUdF/lx7pFWbkUURt7ApilF0wmwE7tt?=
 =?us-ascii?Q?Y8ywJrUW/tGVYmKy8ok0FJ7Nz9Awh3hDHdmv5twZAWE5q7ZSvysvqzPZrgq0?=
 =?us-ascii?Q?7UC65d/dN2N9Mc1yK3xgBZ/u0ZMM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T+NKw+YTtIsT9TMJY4lIUwr2/a5M8y7CZezlA5WTalUfuQIG5wGJu+R7Q4kg?=
 =?us-ascii?Q?MhPvJmeKqhPLIr/QCk4ldHTACaURuDsIXTPiykDtSKoAcUwak2yfCPxjGM63?=
 =?us-ascii?Q?KxGBxceGNYpRP4OvoPZwdoVF0smb4VEFOQNkWVgqlrdJd5bZM5wEDthocOIq?=
 =?us-ascii?Q?Rt3bN1HcI4f5WSRD33hdH2HTyTt8foCwqEzKtdszGwp/yJ2cDv/MrvUwb512?=
 =?us-ascii?Q?PP/zyC9lpKBeD2XYL6z4l09WVfinkBpqf5wxWRA3cXoJO2L8pMIeuA0er/6f?=
 =?us-ascii?Q?t3PMkgcOqpwXl0TLf1pVPNvB7zu3eeaMOdA4dPXrcHyea4BzA4HL20/34LbJ?=
 =?us-ascii?Q?ppPyTndKDKbdnOjyf9AtApVhxnTwfKq15gRCCI8GC+Wmu6DS5hidOTCkoukZ?=
 =?us-ascii?Q?79A2iU78X39s/iVM9DQ8xigLkeROiEOslXPBUDPs/l2M26i7fSxYiZ8cEVVs?=
 =?us-ascii?Q?295Ku2SEcu9kgEgFGNG/CFz2lRESvLONwB7hgzgZYipRMFoHuksSLLOtno0k?=
 =?us-ascii?Q?sq9KDsDJdxGpdG7Ac/gvas0nnVRaFPWQuePppdG5YAORhL2QzL1+NgZHXGHJ?=
 =?us-ascii?Q?AVWlpW6RFRem0VpZC6Jw5IaY2EggNL+Z6wX53yMtlVkAp8yV2iFEi6dfwNNo?=
 =?us-ascii?Q?2+qHgGY2ZEKuY3roYDTgJr/uHK26YSmldUtLP8ZN6rYXbeAphqorCclOX9Dh?=
 =?us-ascii?Q?RhQ9Vx5Z11sUHvyRlK05NQkHX7DXN+6eif/Mv2CX9uSEyNPJvLZIFNRFJPQn?=
 =?us-ascii?Q?eE92xTiHQLAhG4WLxeLMDvxCZxM8vcU6dMAERFRtbG5x/IdxG1XOPV75JN+v?=
 =?us-ascii?Q?ZUKFpbyfH9r/ZTVFU2+XpE9qgml6+JG+13lzL1o8YrJ1qZtLJ24Y3nWh3eu0?=
 =?us-ascii?Q?9BWxaf1dhY2SKejCgf4wsVDAHZQdKfwuZ8u0lhXcKSeKX2sHzMtMRUufNmZm?=
 =?us-ascii?Q?vf9xcOrPAqwEAw2+AHqlwJkjji7VjvM5EZunv/HckT+MYVP+9HGRjQ6P0UdV?=
 =?us-ascii?Q?68Fp1V674zC5ePHiWPv7x2XOcckp3ye1uA9ktDa3uizxwXJgeUbdzGvy+zfa?=
 =?us-ascii?Q?3OWqHsGbJ9wnvliNF1VDjN7j7k3ts+TzVSGAWUhmPBDJT1GZ71gJnMAGgheb?=
 =?us-ascii?Q?+YnbSnp7lmnjSkvOmcZspCZ2Cq2uVIUPzkFwU+w4ogWKo0bvmj2zdZeEOnSz?=
 =?us-ascii?Q?tHikfaPRNgpJSxN+AGLphz7Z8xm66f/K+pX5hHoep3YoPwhHlPuFWcL5AkRO?=
 =?us-ascii?Q?5EA45Cj1UEKZI5r3j8dB66lzdNzrxZIK5BpntHwsohLe69M6FpaaK0IWPDcM?=
 =?us-ascii?Q?DjuXb4TkIC4llZJqiVyjAQP116hpFChy2vQJbWAYLzKiR0Y6nXRfpRY0SIfa?=
 =?us-ascii?Q?P6Oo1QVKFvSgqfeC4ERtcYfne6HQgL9q1scKQWgfjVGLEvGqYVPyumm1Oy86?=
 =?us-ascii?Q?LMXtI9qiSAVw1RbBmMqgA1cTLMleVGTmGjywMWOkVJsjRWnOZApDS8nhKjsw?=
 =?us-ascii?Q?tS4ceHgJdTqvnLW/O0D+nSsPd1WTg9lemQWgNi+dG5m9bRHRrh0NT2ONP8jY?=
 =?us-ascii?Q?CeD3YS3yI4ImSvwvOPBrUTLH3mr1p4Z+C/P/uCPx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed62030a-9ec9-4ae9-0741-08dd5d814cf3
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 14:06:48.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWGGn8MPaobnfRZ0rcqFYYDMzriuzUIbquTJeuBE7wHlrh2HUEqKfVlwf3ZQHOf3yO+MVZMo7bsjy42dmymj1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621

Hi Dan,

thanks for review.

On 05.03.25 11:06:52, Dan Williams wrote:
> Robert Richter wrote:
> > A small series with individual patches to handle inactive downstream
> > ports during enumeration. First patch changes downstream port
> > enumeration to ignore those with duplicate port IDs. Second patch only
> > enables active downstream ports with the link status up.
> > 
> > Patches are independent each and can be applied individually.
> > 
> > Robert Richter (2):
> >   cxl/pci: Ignore downstream ports with duplicate port IDs
> >   cxl/pci: Check link status and only enable active dports
> 
> Both of these problems are to addressed by work in progress patches to
> delay dport enumeration until a cxl_memdev is registered beneath that
> leg of CXL topology.
> 
> I would prefer to focus on that solution and skip these band-aids in
> the near term unless there is an urgent need that makes it clear that
> waiting for v6.16 is not tenable.

Port ids could be set only by hardware and there will be no other way
then, than the driver to handle the duplicates. Relaxing the check
looks reasonable to prevent the whole port being shut down. There are
other cases where dport enumeration also just continues, e.g. if the
link capablity cannot be read or the component registers do not exist.

The delayed port enumeration series will hide duplicates too (not yet
tested), but since this is marked RFC and 'long term fix', how about
having those patches first and then update them with the delayed port
enumeration patches? The duplicate port handling could be changed
again or even made obsolete. Otherwise, until then, the kernel fails
to enumerate CXL devices.

Thanks,

-Robert
