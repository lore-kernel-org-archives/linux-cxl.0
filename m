Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383D1F1516;
	Fri, 21 Mar 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553285; cv=fail; b=BQC1KdVHTXqIzwijvihsgRFeomnxTD29bFDjEQWt8qytSGm+zPRYFlRle92jFE3UVEcuEicQd9wKIMCBsnvOXpYofx/cNLPXnU0koFTrLQpJt6MWRiT1SCGSE1SI7Z1DNNFv2FYxl20RIAGoSx42N+adFQivqNB9mrr9AYBM19I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553285; c=relaxed/simple;
	bh=1J/Lv6Xi7wNDUStUOHmiF6cVVDK9OaUeJgt9TvrC+aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B0v3v4gJ2Vrdr5uKHM6B3Eao6MyRJFqoE6kQxeCFb5u2HXfUXoJOXkD88lydFaYeoB7Otlk62wcWYW2Z1Vsk13hYQmKyRdz6NvsEevsXUcvJhZxL4lYwd8u8vrXDeKbIIzRupK+zyCB8hcM03aapVnAJEU6G/PhsAIcVwRNG+4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dw3oCsXp; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dw3oCsXp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK+w0JLXss9np1A7DZvKfcWVlk+XBKkjOjjDK/WqUqyaVbnmZ6mAeZqhmzNcvBQ6bkXZYK8EA/sn759U6CZ+b205oerjpP3CwfiDoTdtAMAMsCRAoc2MNvaKmsSqcPK4BEkXAbKwnoNBm5uqCqM8J/Qqez9Zv867m1sBLwg+1xZdGj8rexReSGDHbDXuMxO3gbVqsVO3rX3qCehdVSipeGA3pyI7lw9n7kTP7JO+VyqsmzdzNshN5ytxNwN+aaLl/AeIQUX9AvkCBrkQFj+mCUVLOp/1DXiLeoeicFlpdZXja4c49MWIEDsP9NqrGd5zor9rVwN0uy3EiX7TJ2TS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FmwGz2tPoQmv5MPOEXimwZqMIhYNZrfT2aJfx2Kh1g=;
 b=gPc29sisywnhrQrAHd9QbioI2xHIMwNjyl5eHK/0K18dHNyolkZO1mjrjwCwkHR/MLfSgD28heHbUd2OheCIuLG0t8RIoyfu/G4ozRVZg1/E/pBAIp1q2mqU+gjyaw4v9jjIZZctIl/veTcYqyChz8cBF6ClrvbhdY1h8zg4Vz43Xx+5c2A+oGhSDgAfEUhFSfk4P4Ht9c5N/xrec//EhZJcdkzm0KWYttuX+7KEjE/lmdeLjrWoOXFkiFbZwihZ8ex/Ttl9azE9mCEfEPc+4BBCLYfPS335gsm7XSQWabT5yomAgEfd4+mDhEc9zvFQqQR9ZGXQ73tE5qKkTgTCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FmwGz2tPoQmv5MPOEXimwZqMIhYNZrfT2aJfx2Kh1g=;
 b=Dw3oCsXpcBKGbVSOSkw4XZplhZxuHy31DRw8nJhSi+7G5W8YJHNTNeaU8qQ5r4uk2LiB0CdmJirjhZ0IUF9YUFBKeNlO2p2653lfNSQiNj1DqWWCfETeVJ2804msCPkwnCU5hz/5+5jBZYkhplgA9GZ52T+DeWFYN8x7YIIlzqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 10:34:41 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 10:34:41 +0000
Date: Fri, 21 Mar 2025 11:34:35 +0100
From: Robert Richter <rrichter@amd.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/4 v3] cxl/core: Enable Region creation on x86 with Low
 Mem Hole
Message-ID: <Z91Au5en7r6D7IsW@rric.localdomain>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: e501428a-7764-420a-b04c-08dd6863fd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E8Z1CHbO1jRyZiKtHKoxiIDygXrX/slQgVqtMgKwNdXpghmC9qvgaSkV0m4O?=
 =?us-ascii?Q?dGeunbKs6JIMkDthDbFjSXOL5wIK6UKC6nnCKKYX7HM0Y5Q2Lw+L4A75txVw?=
 =?us-ascii?Q?/pPSu06OARbCm1LRXPMOMYXbHY/srAiAq6a6bhJfDIyblj+053WTHh9tl6uk?=
 =?us-ascii?Q?+JnOXntD/QCp3cPIarj9b5CEBFfxKgTWbSG5ZuelluKZjrYhtXXis1xAz2W+?=
 =?us-ascii?Q?B6pLNriF+nFh1GeCwxxfJUOupcsHV/9esqiLNpShqe0Kxou9tMO4fHIBxuQI?=
 =?us-ascii?Q?ewBJNzVkWTrP6qkXF7JMBFT03ua1EEUKny7mNLQrpowYbi+qCx73mkYP3nuq?=
 =?us-ascii?Q?wbg08vxZl50wmXbb7EFMEV60qgsGV5Ns113GMX4rP29AWb7vJWtuApytyirt?=
 =?us-ascii?Q?CdiUpwDBx8+ghFqkrofnNq3+mJTQ5tVv78xCgL8PG3//p1sTqlTw6c6lgDv+?=
 =?us-ascii?Q?hW4w7QaffjZ3r9pD2nxC878hjAftUAiaIlZmHTAuTLZGvguci7za5QfWUJB6?=
 =?us-ascii?Q?F/EQcT3tTpFl/B7GRXV+OsiJtMvQn8FhLL5FDroj2ixx2sby4aCKLBk8X9ym?=
 =?us-ascii?Q?NaUrooYuz99mRkwP4GuGA1N/+6nuVaVHr3ccE+KGvhNoQ4q7Gwz0lcnyELak?=
 =?us-ascii?Q?i0TYQyHTyvJsThHkq/By0humgCikkpJts5fxPfCQ6nqZewfsDX38TZ6bPRRv?=
 =?us-ascii?Q?ErV7IiNNPdlZ8BV1IPrflcKNKjva0LKXHQCNZjS1il1bnpRXY5waHt7UZ/i0?=
 =?us-ascii?Q?aeiqM42mMLzh9tyH0Ra5fZ01U0hfXgIlrtiVc6aFDkJYzWmr7T7FNUNrsNoz?=
 =?us-ascii?Q?EieEBGVxPZAFoH0kRz+Ys162XZCl1vrNC06ovj+fIjOZxRdN5KI+W0smBBae?=
 =?us-ascii?Q?MDtxIw2D1AwvBp73oRtsGR/dN2TEr9NQNwqvQA285cVC0XAvFFue103+QZYS?=
 =?us-ascii?Q?e9RTEvKQpgrQrZI3UHcI+pxEJn2XFL/fuwIQddjECpsqJ1GDUW8nvju8yrDx?=
 =?us-ascii?Q?UxZg/PlffWMX3YZGSp1gnZ92tEmec2IRVubZTbyFkk9SRwVCNx+tDXfeqc0S?=
 =?us-ascii?Q?L2yofuxXL7NYgSCDAkyMMSpCZKip3A6qeIRkpMaT/4Re6GuH8J/ykjaZCEe4?=
 =?us-ascii?Q?b9hSGBdw4bWUs6xadZARLZkIYTe5SLiZX0Nv78E7tQwa4aWXTHGLW1vRsjvm?=
 =?us-ascii?Q?IZfLZmlduE+lODt9zCg6V8MqKMdvNZlv1uklLtBS//lXaTqX3MwSITbrxMWQ?=
 =?us-ascii?Q?wSMfr4Ftm331LTQ/VcbjlrPTctZPNqaDy/kZs2pp1SAGQFq3PizlrQDQkRMN?=
 =?us-ascii?Q?mtEuxl1mXr23e1qboI0F+9udksXuFtgV/kM+GWrcoDuWMa6CeY/Zmm3sekBq?=
 =?us-ascii?Q?lzRj7oPbNDP+TK8ageBuf+3S0fau?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xFLUDevboZsPCkDEchn343Wig+oqLFlozaIVBcwv8Vuxqfx3ufbo1C5X7eXG?=
 =?us-ascii?Q?hWjIXtPv4Bkx+yzYyKYiXvj3t3KxYkFekLXlil9YZNWDkC3AH4J07EdE7a3u?=
 =?us-ascii?Q?2JBqQKbtsRzzCqGYpBDchoAGExbzbxGSUK91xTBmdpB9hQk1OWjQdqDYN7sF?=
 =?us-ascii?Q?++n9R/KIC/6mgtl1X8N1NIJ2pJFzn0Dj3JSTSgVHy4hJr5wev2ZxbpeOQsZ7?=
 =?us-ascii?Q?Sg4/qDG317V/iGvdGY2zcGl6r38/sasCA0AjidxQ0pgq01OBwEMzy/XLyb6D?=
 =?us-ascii?Q?3Q/itbHxU7awM0T6/K8907MtnMbk57922Z0x0CeYzHgtRCSnte9qZ/AynwaN?=
 =?us-ascii?Q?J/NNMZWByzswSuA1QhNiqQ7dwlJjebDv7x0IrxFaemPR0FOsTnt+NfXbIdN7?=
 =?us-ascii?Q?VQY3i+JOIfpjbLLihRC8+MrfKA76ajfdOp5QZcyv4ZusRPE1V5zx12/c6b21?=
 =?us-ascii?Q?RuoiUM9F9EoBenYRs/0YDqC10Q3xWii0TDi7BfYaMctkJvArCYNIgt3J6dh1?=
 =?us-ascii?Q?7uI9rHNsMLSLUZyIAXjufq+z71wtC4K9+FltApgN7yq3lNpltss4l62aC3zU?=
 =?us-ascii?Q?jwrjgN8Jr//ZUZbUqJFxI3FOQUk23594Ad4SHrxCcE+85Zi/0AoG3yvR7pTK?=
 =?us-ascii?Q?mr/yKpMph7Z9bZZgXsvqfuRBBJRwzZv/PsQiYlc5TlzI9pM9h063obsj7yF3?=
 =?us-ascii?Q?63ft5ah4snesu3tmHPWfMgRAANn22s2rhIT8xPnVOTTz+2vgnvyyyhp6AEpc?=
 =?us-ascii?Q?6mIfOQ78yIjoZ68+8JrweZ9RGtcdOhTPdF8hMLMO54bngk+NKJ7M3FBiHOWV?=
 =?us-ascii?Q?lM13FCgMp8eLOzpW5BFlt1xjnKvul21wShbTBX4rvgZtlUCrqkvObTY2q5oi?=
 =?us-ascii?Q?4MoUfEatvx0xYBfq0kike/98a36+5TKugi6nK5b60wWjI0HCG9mmU2bbNBOs?=
 =?us-ascii?Q?kgm5ilx0Pscme7sdKk9cqT5b/SkmzaTu6nGYOJ5HRN0TSN6SuWcrbeLVGKT/?=
 =?us-ascii?Q?qCYctJBksJ7f+wxtOzbRHyoCRFHEIxmTpQ7Fz90NGH1CWzKltozYa7Qu5zG/?=
 =?us-ascii?Q?tt7gw9gbMY+cvx/oGr2OLZrZoACckD9KVOB0P9CqULu7T8WBdEGtj/JKvtuC?=
 =?us-ascii?Q?KmMRV4lkkOhNGjJD3mK1F84fdKJFBYHKPw2Gv1nE6Au/fRoyUGptP45CL8LI?=
 =?us-ascii?Q?+YwcbERKpyANXg+CSIGJTMUJjFTo8UFj73kGuQn8sQiMUJZ+OqpWe/6o8ddJ?=
 =?us-ascii?Q?dT+w9mjDQw/LBwe+XMvH/CkPleaObUt0ZLia+wH8OPKainuVVLMnYSCoIS9F?=
 =?us-ascii?Q?ez3AAAUgqr7fVQhnVDs43wfbNXiNvnv3s2Gc5PglpncRTHou9t6ML0/RHiMG?=
 =?us-ascii?Q?YFOJ9+olsZ2Mk+o1helodaSnXNh4uvtsU9dvrqUf1IQr2U3lQnKcXSbHsDth?=
 =?us-ascii?Q?B05sYa0ZoiCOn17AZiBOumTdX4UtvsgprL6ll74tnxTw3mIihCAz4NLDEVOk?=
 =?us-ascii?Q?UBmPj/ORqgGpt0/3E+GnZyCVZDtTbkkUEpVlBtAyZ66t3u/qrhVIY/Q7XcFF?=
 =?us-ascii?Q?7EhAllgNHNkE22tXEQVxsqIySlYDhsTg8uj2NqJ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e501428a-7764-420a-b04c-08dd6863fd35
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:34:41.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQY/sAvRnS0gDolsLXL0MXsXcMEgUJfjp+VvcyTNkwfJcdaCR5dZihwyZcWARU6GjjyZT+w1pZKvfv7LSKjIMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074

Fabio,

On 14.03.25 12:36:29, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. On those systems, BIOS
> publishes CFMWS which communicate the active System Physical Address (SPA)
> ranges that map to a subset of the Host Physical Address (HPA) ranges. The
> SPA range trims out the hole, and capacity in the endpoint is lost with no
> SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, the driver fails and returns an error because it
> expects that the CXL Endpoint Decoder range is a subset of the Root
> Decoder's (SPA >= HPA). On x86 with LMH's, it happens that SPA < HPA.
> 
> Therefore, detect x86 Low Memory Holes, match CXL Root and Endpoint
> Decoders or already made CXL Regions and Decoders to allow the
> construction of new CXL Regions and the attachment of Endpoint Decoders,
> even if SPA < HPA. If needed because of LMH's, adjust the Endpoint Decoder
> range end to match Root Decoder's.
> 
> - Patch 1/4 changes the calling conventions of three match_*_by_range()
>   helpers in preparation of 3/4.
> - Patch 2/4 Introduces helpers to detect LMH's and also one to adjust
>   the HPA range end for CXL Regions construction.
> - Patch 3/4 enables CXL Regions construction and Endpoint Decoders
>   attachment by matching Root Decoders or Regions with Endpoint
>   Decoders, adjusting Endpoint Decoders HPA range end, and relaxing
>   constraints while Endpoints decoders' attachment.
> - Patch 4/4 simulates a LMH for the CXL tests on patched CXL driver.
> 
> Many thanks to Alison, Dan, and Ira for their help and for their reviews
> of my RFC on Intel's internal ML.
> 
> Commenting on v1, Alison wrote a couple of observations on what users
> will see. I suggest anyone interested to see how this series affect
> users to take a look at her observations.[0] Thank you!
> 
> Changes for v3:
> 
>   Re-base the series on cxl/next.
> 
>   1/4 - 2/4:
> 	Constify local variables.
>   3/4:
> 	Call arch_match_region() from region_res_match_cxl_range().
>   4/4:
> 	arch_match_region() - Check that region end is under start + 4G;
> 	arch_match_spa() - Check that SPA range start is cfmws_range_start.

I have sent comments for version 1 and suggested a simpler approach
for this to implement. My comments haven't been addressed yet, but we
need better isolation to reduce interference with other platforms and
archs. Please take a look again.

Many thanks,

-Robert

