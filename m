Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792789534;
	b=G+QLbVQjS0Yz4TkQsPR3EEnfk7e8S5yTYfZeHCeAHFQvNefbbGouoy11zXBpeaENuvM1
	 kf2y+/4yoLtF+kkFcMDwEEzBM4xuC1zUxIvgn2/QY4kW7yN/Gmn22J8nNmptW5Hg3RUlH
	 iWHBZZVdO99yOEw6hiv2qe8KOhIHk1zkkY3P/KzLmZJqE+O2C0O3eVuJ1XLVsi+xjRLZ7
	 4dlQlFsMPNj6Hp+cMY3Kc8zsnd9shGX9Z+GYiQG6w+Ruxy2c1vZ69cDJ6z/VIhQIFJQpK
	 XDCq201xB8OU2XimjXPCWw/F3oT1arHTcQczKIIUof8VM37V/bMfn10CpbqbDge0W0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789534;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ya6TeX4jVc1CRBLI4W4H1aQxLIAJ9QqvYV5IQfTpIy4=;
	b=wKc1fHrbMsUI2DujzhaDP+55VFo3o3w+H4OSRFCby8MO4QEJPW3zmNtSc++rs8+Ky98a
	 7EgsYwlqwbQGa73DXer0ZsBS9qR//UCqE0eHxNl3XEDUOPQ7Te2wscCZm/eXhUlsC0U8X
	 ovuaemmsxjyrnsr0dDBYx9vFJmNLd0rV7pdq5cKYP4cQqqBsHSYvjDxy4HnSXDyjbdNqJ
	 RJpOJDLiErIu/kh+H81rXS2u/8jq3RippvSMjHicZKBGLx3Y2LzrF37IEoGkSNKeiNxQv
	 rNJVCs38b2VobFY6c7eheZ9mqf+1kSEgOOKGwntKO+WnzRjkvE7qVkr7WWeI3kBPY/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="GB4olL5/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.67
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E48606A31A;
	Fri, 23 Oct 2026 21:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E48606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GB4olL5/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcuYWPVsqLaA1bHwb45m+hFoYp4Eq43A/Uhq6SrMPncr/f+4OwV2pzJ4QEpgXJ/3Nq3zGyzpeQHWXzqqmY5V42FB70D8+meRbVFTnYzXgexMU4UtHgL4Z2hduS49PHZ2Y65QhnIgRTG/CQF7eVLgL6ccBkVqcljyLGs59Rd0lY4or1Q1FClHTzExf2KlqGGnivSBATAln6xegh8YiNc5237RfH7vN6+WE9siDFlcNfk38fvtcUdxu4+c85fjhMFZioF6zDN/nNa7zCENFHLEzMbCX60h9kRGbc13kLGbhvfKgcmv9bxKeMV2fxNJUNcxz1M+bxuttXl2lPoHXjpM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya6TeX4jVc1CRBLI4W4H1aQxLIAJ9QqvYV5IQfTpIy4=;
 b=VSV+As/7HmW7dRvKGiy0EhpP8X/zkTeWMsSJl+ar8m4Y3AEjcuIBuJCQxjV7/NFjTakYp2BjOudyJ5cs4w5g4LJcWhVLOGVBYhJIh5aKDMm1My8tW0AV6ku+W8Qnq8wnhKdwLgCoUY+BDXsXddUtxma+1fHf9/rf/9HVeHhb8rUPq2U2V72FSRIxUJec3ar5XZl0C2222pda+3XwzT0KXvb6Bldzb/FiHJdA5dgVltXYHO/9n4forwswzyvXdUqvrKocscb/hcPyjAM7nGhm/CmAY1pn1ZNTOjkAx7KjPX//nm8h/3zSYbLYuDFIqUaGEioSdxmswk0hCxxVra4Xkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baidu.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya6TeX4jVc1CRBLI4W4H1aQxLIAJ9QqvYV5IQfTpIy4=;
 b=GB4olL5/g/njbTA7BX/mkQBkgfUy7oS4QO1+Ztoh02wbb7bOHdNuHXvn9HGc40wBZweOlWS+45jgnLhYzb/IBQ/GBYzhWjVBWAtA9FfqN9ANqSdQkCbB1O5C2sqAFcf9Pcl18o17JhVVRJw/KENJvkSt376XK4+Lc8NgmISAQ9Y=
Received: from CH2PR14CA0043.namprd14.prod.outlook.com (2603:10b6:610:56::23)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 21:05:30 +0000
Received: from DM3PEPF000265C3.namprd03.prod.outlook.com
 (2603:10b6:610:56:cafe::7b) by CH2PR14CA0043.outlook.office365.com
 (2603:10b6:610:56::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 21:05:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265C3.mail.protection.outlook.com (10.167.23.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 21:05:28 +0000
Received: from [10.236.181.175] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 16:05:28 -0500
Message-ID: <099f0eea-1ff6-4e1a-91cf-682fd7609808@amd.com>
Date: Fri, 23 Oct 2026 16:05:27 -0500
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/edac: Fail ECS threshold read for reserved
 encodings
To: Yili Zhang <zhangyili01@baidu.com>, <jic23@kernel.org>
CC: <alison.schofield@intel.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<djbw@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shijujose2008@gmail.com>,
	<vishal.l.verma@intel.com>
References: <20261021152053.85322-1-zhangyili01@baidu.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261021152053.85322-1-zhangyili01@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C3:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: b83c3302-2868-491f-b622-08df31495de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|261021121427099003|18002099003|22082099003|3023799007|11063799006|10067099003|261022105027099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	48aRDZk6VEqGALmnWXHdKL2w9TZpXF+TafEfj7JUK6cJSIZqrU8SzMpi3ahAenEnnm5tPPEuNL2PTMu/KB8TsEvx3WfZ+bBO4ZlKjP7M6D6qTb8lSxF4dlSEs5kWtUUqCRy0L7TKiAKCistbHRG/gDGsqi24FQSeu5QRslH2DPiFVeb5k8v9lKx8+midiRYThuvAmloLOpaTIv471FZBHuawsRNfISCkwV09sRdvo59PjREZNZYY9ltpWOr6yVT00IWGEeaQi5FP2VC/Ynm+1PlTppDPAEeRZz+SYvriXHk6/gfoQLMdfBruV4FvI6VmhVMdpna951+gsWZHi6hgxEpO20FsKqXnBnT0CwlT9IaUmU0uCccIFVDPNEwVqByxBh+Kewv3XY62ppYwpkvz6HUkC0e3eworpfvimUFZqQpAM48uiLu9hWS2jI2gGoTESfmvw3qK5arYVQbbCTlqqzvLjClLpEx8pmLwxG8ddIblv5t0SEHXWlfvLyP/mFT9oVOQDmjER00eQomJniNHeejv5Xe+cwduZ7eRFZtfIl0jf5t55NFoUs4QiEybBJsz1XgiKY9D1R7Bh4Usq6/mLKkGMakirF4mCQLyVxAxbaZTfmxfkr6fekZgv+CGGgpYTBlqpUlzr7uUaWqgD8HC5SHPoYBpWckl0g32YnhWpXR9qQ/iUr5UU6DIpAjNMWviU5WM0KclaQSdKa7QYUTX+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(261021121427099003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(261022105027099003)(56012099006)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8FM1OnfEeFbJTg33Yd8dN0hFtKzPtQFP68ymywRRhfNa9By7sdu4nYmIokhNYB4SWmO9cG7nABfJ9tQzBcCPpd8g+MfTqsBsD7XdOhBuNQ+2HymtXCqnI8/aL+OdAP92fgCpuj7g5W8m/teGe59aXCauNbxdHGqfWdC62c44D6f2kRKOi9bqsvWWFVCKtdoh/qvdlx9v/OjtEyz44pOD6BQNYE1ysXVdjDgB0mUM1rU+ShTBKWpmlxuLcAqde6mquO3OMZsuhv19MuJn/X8SFQ6V1unIgssLcAjDmJPttK2e22zB8oLsvj4olsLSLvoVR3cHeIOmHW6KZojxBd61vXW23iLozfTESLiDgQ8UidC7LbTHTs5mmjgdF/+2guDy22QirmralPzKNQ92W+wnBwSkrq5NVYyOLUz9cPbmBqi7j77XaOrvyRo5g2ZZp/iO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 21:05:28.6530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b83c3302-2868-491f-b622-08df31495de1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625

On 10/21/2026 10:20 AM, Yili Zhang wrote:
> cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
> device-supplied ECS config word and uses it to index

Nit: Should probably spell out ECS here for people (like myself) who don't
know what it means.
> ecs_supp_threshold[], which only has 6 elements. A device reporting
> index 6 or 7 causes an out-of-bounds read of adjacent .rodata, whose
> value is then returned to userspace via the EDAC 'threshold' sysfs
> attribute (small info leak and wrong reported threshold).
> 
> The threshold count field also has reserved encodings 0-2, which
> currently read as 0 from the sparse lookup table. That behavior is
> not intentional; it is just an artifact of the array's implicit
> zero-fill. The ABI documentation only lists 256, 1024 and 4096 as
> supported values, and the write side (cxl_set_ecs_threshold())
> rejects everything else, so a reserved encoding can only come from
> the device reporting it. Rather than documenting 0 as well, make the
> read fail for all reserved encodings and only ever report the
> documented values.
> 
> None of these encodings can be written through the sysfs write path,
> and no device is known to report them, so this is hardening against
> a device returning values not covered by the spec rather than a fix
> for known hardware.
> 
> Convert the cxl_get_ecs_*() helpers to return an int and write the
> attribute value through an output parameter (u32 * to match the
> macro), so that errors propagate through the shared
> CXL_ECS_GET_ATTR() macro to the sysfs read.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
> ---

I was going to make a suggestion about updating the documentation to mention
this new behavior, but noticed the other attributes in the ABI docs don't mention
reads of reserved values resulting in an error. The doc mentions that these attributes
are implemented by the device's driver (duh), so updating the general docs doesn't make
much sense.

So I'm going to take it a step further and ask if we should be failing the write at all?
It seems like other driver implementations probably don't, so it would be weird if just the
CXL driver did. I haven't looked for any other callers, so if CXL is the only user then
the docs should probably be updated so other implementers can follow the same convention.
If not, then it may be worth looking at the other call sites to update their behavior.

That may suck to do if multiple subsystems are involved, so if everyone else is fine with CXL being
different then I guess I am too :)

Thanks,
Ben
