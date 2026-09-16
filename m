Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED14EBAE1
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559479; cv=fail; b=s6QJa4pndWh6c/EwrzclimJt+ug2NzkN9X2Y88gwObniHCN2xUpaxEq9Ygnfp2UZ7FAI+hi4M9mQZnZSJi5Ms1xwn3eQ4XoB/W9Lt8yG/sGF6uoZFtG6Qkq1137BbjUBZdkyNaYGMDGN73ETwSjpcOeJhLZHXncMPPmjrcV9C1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559479; c=relaxed/simple;
	bh=uCP3qosSOTLrYZDK5odULm0vyaHSkYLai/IuOwgvA3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cAjuwjwT63yM1XaQTGCd7OVXCIl36BwukSL9qOUaD0SeD7pgRJmUij5FEkPrqHA1S9r159W0rvLeV7txanXr3f5dQSxzdiE5e/pGqg2zvMO5FlMWt5TZEJR2vAd6eyzPpx2+nFXKx/5IVFlr/q9U6BVFJgdjzasR94U6ZszGBVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fjDubW/D; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fjDubW/D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP2kyIIfr36plg+xtDrKifq+BdKHgaQips4UYOIWOP5Ld18yboblWGqM7x4DfnCll6K/uyuxqHogAQ0dANaDKJ3xTKP3jpmOQkdZTBcRZlx+cgskveZ6hPouYvIp+HvYIhpJ8E3DKlZUJiWbnJXNZLeEIdLuUG0xZWmc+wEqPIzDkRXAuUUfEh56Vi8mDwlXQnVlWFceDs79R5/sjODkYfckI58z/cpU68Zu2wtdpttaCbqHgH661zA7UCsIzi4NPzgOYGTEXeQ6L506mRD9grNpu+m2n12Rmh88NXKc5cLS2tOLIdImTmxwoGLevATcQ053J+N2PDd5eVhyFO1CaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dbw9wGo0gZxkithRLpWxwwQmKsJFG2taY6nRvV0OxaQ=;
 b=uGSSwyP+478LO04WX6FRw3v2C63SLc6NEV/N0E5wn+JTjOac8HvrdL0t0GtpWnzUsr3U5YTGKUn2qoD1NIxivBRgkTJIIvZ5sMtjyX8rzOtH0GxYGLy2Uz+E0txZBRBKzPdefl4bPChADse72pwKmeOmfWunm6DlV9Vjbwbww1RjvbXkuW7uW0LAuVV4OPktzJpWrErnV+S53MhOTM9zwIj3chzQzAktH7BXm9JIlWYbwTa2XUt9SsYVyGw5QGoFgFm57MrxZMQSOg5mgu11ORxxWZybxhf6BUTh9fj/uYF87SEZrqGy7h8wX865b3HKFGoCR2lbI6zWCy3f8xGScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dbw9wGo0gZxkithRLpWxwwQmKsJFG2taY6nRvV0OxaQ=;
 b=fjDubW/DNkSyWeX/JDEnRSTjxQow+wJcre80ufmoCXX2ia9Y9G46az1zWkxAoGC1+UC/Uerql7qf5Wo6TxSIfAY/eHAy9PQTdZvLRgCulGE6FYd9LeeuJ7rxHkSp4RcRPPLP4bcyU1HLeecU1J4cFYOT85ZRfBP+I7aqd++xVAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 11:51:06 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 11:51:05 +0000
Date: Wed, 16 Sep 2026 13:51:00 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 1/7] Documentation/cxl: Describe mixed-granularity
 regions
Message-ID: <aqqCpDux1vOwKugi@rric.localdomain>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <5da4008cde30c04284f5780aadac49e91ae511c1.1788475206.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5da4008cde30c04284f5780aadac49e91ae511c1.1788475206.git.alison.schofield@intel.com>
X-ClientProxiedBy: BE1P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::13) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b04110f-6460-4d26-32ea-08df13e8ca34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|6133799003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6bTdG+WUceNSC+M1wf93c+RVHNFTePpsbg59gCwlCewkTlM7pTMecD4tMFEjSazJApzu+HtKl9kPP1cTpGknza8Gsdcwgim2byF8rsGJzB7zF063Hcv5BRT+3xTlUkglgu3fKSvS12sfQjL9Zpf5qbmsPOQVf0zj/lfbKAHhYQL2av+1gv+YjPvY/vIGGhhdcU2b57Y8SjSRxno2oLuWxt5sZbvMkob0bojS8cLUVZNjzlbsx4eiVFaphJFWmqGeI1zEQa0v05aUwvoDk6sIxY9rHfCHwcXx/el1m2LjpcqH2j9jk9Jinc9WjpGfrP3Zjkf4jY80yyKkLN7E99aCbd++PEIdi4/uSi3JgsGp4wuSzRlKNQtDoC2sGUR3kusVk2m2+ilUdyEyJvfadAV/yKFmhu5wjdrnzdAqQLLqYy/w2Vr9zdHp2CUZQ1fyk1QIOl5c6Qa5STfaNssla2Iu8SGRgC5hP7fBDm2MCltYUVKQRQvk8FR/iyG14PViZS3f9Fu6vJrs8Sc53qafxj8TsI++oMe7PA6NOKFFO7v5o2R89hY2ICUksXdbthRNBn4YF04PYO22Lxo6TOVXuYqtKbD1Xhr/zdc/afbgmgGV2BksEM6sGn9InRXgMXR2q4E9Wa653/qtjNHDle74pXC493NIO66P10bOg8m/AQj3bfk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h3rMwuLSOO88coe1Q+DY56TkrU6fMizRE0oWJixKf8E3sg8t054Bi/hrIAI4?=
 =?us-ascii?Q?eSSftW8JknP5OC/xv2GGQ0P9zfVSupCBB899zVQXsRpE7qcrna4XesYjvlaR?=
 =?us-ascii?Q?u9st1HamXM4azMyeS2PNmF5sUkmbMSZ7YjDhtX7I0EkrNoFOUvAwbGNAhw7T?=
 =?us-ascii?Q?hY524QAWL8z/MIysU18vG70e0S2I7GR6QIYcFUV8CkKOKLdhNPGDl/ydAacZ?=
 =?us-ascii?Q?vdZZdPdL/WhdoAWMrsSohRQU3Ay1KJhsfHviUyJ5VtoPc3K5VVNVKVU28hf2?=
 =?us-ascii?Q?hjqifbTFtOq+PPwbcXb0TtImo/yGopxbbqCLuTXuaTNCKdxGrx+hn+cilM0f?=
 =?us-ascii?Q?t4MW3rEPBDHLTq9NcdNycysx5YiDOweKAwBmZro7gcAjRtMmyTZfO2dMsU5A?=
 =?us-ascii?Q?kopNSBEXtFtYmd8gUtfYC013xQmZ8Ucb//PW2WjIhZC4YnKMAwuJiLDC0ZIJ?=
 =?us-ascii?Q?Fi6cBkvw5qKnTMdLvXFCRV3WTGEzTBz+RPNSlkxDGo6LK7RX1rf/IOgBY/XU?=
 =?us-ascii?Q?n/MBKGxlXpPxK2uc4ao44H91vZqQULqJNklTGlTFg3bIE1+IWcxeKMyuN01B?=
 =?us-ascii?Q?YH55vEXueaAormkd9AH2c484183RBIxg5iYHEPDAEZG5dqJoqgp+hYd5XVIl?=
 =?us-ascii?Q?ZsgTJKMklQ4DshU7CzZFVn+hfH1zXOE8f2X67Mb7WBaWI1lrAaqyuJXPSxar?=
 =?us-ascii?Q?QPa0C7S1bCS+QGjMYK8qbSyLigtAdfDP/e9OTxx/6YAjEdgW5FUd7U2mV/Zk?=
 =?us-ascii?Q?FTrqWrn9QKHuQtjVQbsn7VNWHCxbGrEM6TWXpCkxzdWkZDRZIZ3Lv8CvcI4C?=
 =?us-ascii?Q?rg/in9KkqTdHeOhohHUdBbaPMj/+gslQxHjFmYVHbkN2JOdTzR8XrrsuoKjN?=
 =?us-ascii?Q?zMwTpGzc4XbD9Txeyl/2wVbh6ZpogD9eLjACT+S1/PyrcYix59mPDkMNSMeE?=
 =?us-ascii?Q?aRa4rLD/QPNdqoIN3/KsSRnmOijhOZCK0okwJmfH1MQ6Ze3K8nQj9Rbr2YK7?=
 =?us-ascii?Q?b08r1Ha/nWUeQHwGy6h9Pe/emsdKSLr3ZQaea6Rcx3/v9hd7vWJ+OFRHLQtq?=
 =?us-ascii?Q?sH4Kb2IXbDdH82qcU/s+jWlPg1IMAdcu4phl2zcu943/Lm4f1W1aUbqnwbQ7?=
 =?us-ascii?Q?uImO8UOjEQTAww6uCiM/hUICLIuvPgInMK4E5wyzhzzvi5rKSn//EL2SMTD3?=
 =?us-ascii?Q?XPD8SuRyEzUU5KXQH/+mLGCZNKUKeHCnK5Lktstv1m+myClAWD/L7HCX4s/O?=
 =?us-ascii?Q?fHHzNa9yYyDbgXnDMI5J60pyb6SgBhbNrXY+jrDi6ELyzEaNl7RnO51Rrya9?=
 =?us-ascii?Q?T3sn1ejutxDhM93iR6uq3//iyqaeqE+I2uCyDLcK+B98zlrDPutAKZEoJ3JO?=
 =?us-ascii?Q?O8yGW3OzfWT3p1OtlUlNWDe6+9ZK0e9+L+4jq15PS9XxORI2l3Ydf34zXt6Q?=
 =?us-ascii?Q?citH634gsiWvuz6OlnfTJqCagmThmeUkX8fKn+Zl0Lh+/7/++6gZ5VrrKbGz?=
 =?us-ascii?Q?zMk+w/ABqmybxJ7UVG45lhOXZX621vED/OOBSOeTF7fwhlA6liNmsFkRwLU1?=
 =?us-ascii?Q?si0qzhc8Am7VlRLXK3V1an7F+iU2wFqFY0d36/u0mznsQui4JWCi88AaFVFL?=
 =?us-ascii?Q?CTKEkiGxO7LmQYTdFp3hpYH0XcZfmTaSC60dVTrHprtFnnkuV21hljTe/9wZ?=
 =?us-ascii?Q?N47/Yv4ZeDYe2dfhFfU3L1a327wKL1GazmjMIF63/QFaibi5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b04110f-6460-4d26-32ea-08df13e8ca34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 11:51:05.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jZJOEYuQ0ANmQ4i6ZZzS5h7luxvR2Oa9+fvJia/ba16f0tH3IUuMHBD3gLQecHxB3b3Z0fY9jOPHutVHYziHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

On 03.09.26 16:23:43, Alison Schofield wrote:
> Linux has required that a region's interleave granularity equal the
> interleave granularity of its interleaving root decoder. A mixed-
> granularity region lifts that restriction: the region granularity may be
> finer than the root's, so the interleave refines from the root toward the
> endpoints.
> 
> Mixed-granularity region support introduces interleave relationships that
> are not obvious from the existing CXL documentation. This is particularly
> true for the 3-, 6-, and 12-way configurations and for understanding which
> configurations permitted by the CXL Specification are supported by Linux.
> 
> Document the mixed-granularity model and Linux's coarse-to-fine
> restriction. Include the relevant configurations from CXL 4.0 Section
> 9.13.1.1 and annotate their Linux support status.
> 
> This intentionally repeats information from the CXL Specification. The
> specification remains authoritative, but showing the Linux support policy
> alongside the legal configurations ensures readers do not mistake an
> unsupported Linux setup for a configuration unsupported by the CXL
> Specification.

This doc is too long. It should only contain the following:

1) Describe a brief description of how the specification defines
interleaving along with references to it. Only add what is needed to
describe the cxl driver specifics in 2).

2) Limitations and implementation specifics of the cxl driver compared
to the specification.

This document is ambiguous on what the specs defines and that the
driver provides. This is blurred in this doc.

> 
> Assisted-by: Claude:Opus-5

I am fine with that, but we shouldn't use it to create tons of docs
which we will need another AI assistant again to read. Though, I read
it on my own. :-)

> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  .../driver-api/cxl/linux/cxl-driver.rst       | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> index dd6dd17dc536..a61a20c8bb6d 100644
> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> @@ -602,6 +602,11 @@ derived from their upstream port connections. In `Cross-Link First` interleave
>  configurations, the :code:`interleave_granularity` of a decoder is equal to
>  :code:`parent_interleave_granularity * parent_interleave_ways`.
>  
> +When the region granularity is finer than the granularity of an interleaving
> +root decoder, the relation inverts: the :code:`interleave_granularity` of a
> +decoder is equal to :code:`parent_interleave_granularity / interleave_ways`.
> +See `Mixed Granularity`_.

This introduces another unnecessary restriction: granularity must
decrease from root down to the EP. E.g. The following config would not
be supported:

a)

 Level             Ways    Granularity
 -----             ----    -----------
 Root                 2         4096
 Host bridge          2         1024
 Switch               2         2048
 Endpoint             8         1024

Or:

b)

 Level             Ways    Granularity
 -----             ----    -----------
 Root                 3         4096
 Host bridge          2         1024
 Switch               2         2048
 Endpoint             12        1024

In selector bits this is for the variants a/b:

root:   bits 12/-
hb:     bits 10
switch: bits 11

So the actual requirement is that the combined mask is consecutive.
The lowest bit marks the EP granularity. The bit weight marks the
2-factor of the EP (total) ways.

This series should implement all cases as at some point the issue will
pop up again.

> +
>  At Endpoint
>  ~~~~~~~~~~~
>  `Endpoint Decoders` are programmed similar to Host Bridge and Switch decoders,
> @@ -619,6 +624,154 @@ from HPA to DPA.  This is why they must be aware of the entire interleave set.
>  Linux does not support unbalanced interleave configurations.  As a result, all
>  endpoints in an interleave set must have the same ways and granularity.
>  
> +Mixed Granularity
> +~~~~~~~~~~~~~~~~~
> +Linux has required that a region's :code:`interleave_granularity` equal the
> +:code:`interleave_granularity` of its interleaving root decoder.  A

This statement comments on the current kernel implementation which
this series aims to change. It will be misleading to document that
here. I rather would not document an implementation state that will be
changed.

> +*mixed-granularity* region lifts that restriction: the region granularity may

This term is not a spec definition. It just describes a special case
that may happen. I would avoid introducing it here. If the granularity
implementation ware generic, there would be no need to describe that
special case. So better describe the issue of current implementation
and how it could be fixed.

> +be finer than the root's, so the interleave refines from the root toward the
> +endpoints.  The mix is between the root and the region, not granularity varying
> +arbitrarily down the hierarchy.  Linux requires granularity to change
> +monotonically, either coarsening or refining, across the decoders that route

Why that? It is not a requirement, but a limitation.

> +the request: the interleaving root, the host bridge, and any switches.  The
> +endpoint decoder is not part of that walk, it carries the region ways and
> +granularity so that it can translate, as `At Endpoint`_ describes above.  A
> +mixed-granularity region requires an interleaving root decoder.

Again, this is current. But it does not need to be documented here, as
it is changed later.

> +
> +Every decoder advances one target every multiple of its own granularity, and
> +the decoders below it subdivide the address range their parent assigns to a
> +single target.  The `Cross-Link First` example above shows the other ordering,
> +where the region granularity equals the granularity of the root decoder and
> +granularity coarsens toward the endpoints.  A mixed-granularity region refines
> +instead, reaching the region granularity at the innermost interleaving decoder.
> +
> +Refining is not a preference.  Once the region granularity is finer than the
> +root's, Linux gives each level below the root a single granularity, its
> +parent's divided by its own ways, so the ordering follows from the region and
> +root settings rather than being chosen.  The CXL Specification permits other
> +orderings and does not require a monotonic one, see `Mod3 Interleave
> +Configurations`_.  Reaching a fine granularity as early as possible remains
> +available through `Cross-Link First`, which this does not change.
> +
> +For an 8-way mixed-granularity region at 1024 below a 2-way interleaving root
> +decoder at 4096, where each host bridge interleaves across two root ports and
> +each root port hosts a 2-way switch, Linux programs::
> +
> +  Level             Ways    Granularity
> +  -----             ----    -----------
> +  Root                 2         4096
> +  Host bridge          2         2048
> +  Switch               2         1024
> +  Endpoint             8         1024
> +
> +A *region position* is the index of a region-granularity chunk within one full
> +pass of the region interleave, and each endpoint of the region backs one
> +position.  Each decoder contributes to an endpoint's region position in
> +proportion to its granularity::
> +
> +  position += target_position *
> +              decoder_granularity / region_granularity

The position is used to decode the DPA to SPA, and that is the actual
definition of the position: The position bit mask are stripped off bye
the endpoint to determine the DPA. Vice versa, it can be used to
calculate the SPA by inserting the position bits (mask size depends on
ways) at the granularity boundary into the DPA and adding the HPA
offset.

The above definition is just misleading and only reflects this special
case and implementation.

It is also odd to use division when bit positions can be used. Same
with the multiplier below.

> +
> +That multiplier is the *weight* of a level: how many region positions pass
> +between successive advances of its target index.  The root above selects a host
> +bridge every 4096 bytes, so it advances one target every four region positions,
> +weight 4, while the switch advances one target every position, weight 1.
> +
> +The two orderings weight the levels in opposite directions.  Refining, a
> +level's weight is the product of the ways of the interleaving levels below it,
> +so the innermost interleaving level has weight 1.  Coarsening, as in
> +`Cross-Link First`, it is the product of the ways of the levels above it, so
> +the root has weight 1 and advances one target per region position.
> +
> +The ways and granularity of a mixed-granularity region must describe the same
> +interleave *span* as the root decoder, the address range in which the
> +interleave pattern completes one full pass::
> +
> +  root_ways * root_granularity == region_ways * region_granularity

How is region_granularity defined?

In fact this describes, that the root selector bits must be the upper
bits in the selector mask. Even that is an unnecessary limitation to
implement support of "mixed" granularities.

> +
> +A region that does not describe that span either leaves part of the range
> +unclaimed or reaches beyond it, and Linux rejects it.  A same-granularity
> +region below a power-of-two root decoder is exempt: it may be wider than the
> +root and repeat the root targets, so its span is a multiple of the root's.
> +
> +Mod3 Interleave Configurations
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +A 3-way, 6-way, or 12-way interleave, known as a Mod3 interleave, selects its
> +target with a factor-of-three selection rather than from binary interleave
> +selector bits alone.  CXL 4.0 Section 9.13.1.1 defines the 3-way selection as
> +the address above the decoder granularity taken modulo 3.  A 6-way selection
> +claims one binary HPA bit at the decoder granularity and takes the modulo 3 of
> +the address above that bit, and a 12-way selection claims two.
> +
> +The factor-of-three selection is not an additional binary selector bit, so a
> +Mod3 interleave distributes across the hierarchy as::
> +
> +  3  = 3
> +  6  = 3 * 2
> +  12 = 3 * 4
> +
> +The cross-host bridge selection carries the factor of three, and the remaining
> +x2 or x4 is binary interleave selection below it.  A 6-way region at IGB across
> +three host bridges is therefore::
> +
> +  Device-level region:   6-way @ IGB
> +  Cross-host bridge:     3-way @ 2*IGB
> +  Below the root:        2-way @ IGB
> +
> +where both levels describe the same interleave span::
> +
> +  3 * (2 * IGB) == 6 * IGB
> +
> +The CXL Specification defines the legal Mod3 compositions and is normative.
> +CXL 4.0 Section 9.13.1.1, "Legal Interleaving Configurations: 12-way, 6-way,
> +and 3-way", Tables 9-6, 9-7, and 9-8 list them for a 12-way, 6-way, and 3-way
> +device-level interleave at IGB.  Those tables are summarized below, annotated
> +with the subset Linux supports.
> +
> +CXL 4.0 Table 9-8, 3-way device-level interleave at IGB::
> +
> +  Row  Cross-host bridge  Host bridge    Switch         Linux
> +  ---  -----------------  -----------    ------         -----
> +   1   3-way @ IGB        none           none           supported
> +
> +CXL 4.0 Table 9-7, 6-way device-level interleave at IGB::
> +
> +  Row  Cross-host bridge  Host bridge    Switch         Linux
> +  ---  -----------------  -----------    ------         -----
> +   1   6-way @ IGB        none           none           supported
> +   2   3-way @ 2*IGB      2-way @ IGB    none           supported
> +   3   3-way @ 2*IGB      none           2-way @ IGB    supported
> +
> +CXL 4.0 Table 9-6, 12-way device-level interleave at IGB::
> +
> +  Row  Cross-host bridge  Host bridge    Switch         Linux
> +  ---  -----------------  -----------    ------         -----
> +   1   12-way @ IGB       none           none           supported
> +   2   6-way @ 2*IGB      2-way @ IGB    none           supported
> +   3   6-way @ 2*IGB      none           2-way @ IGB    supported
> +   4   3-way @ 4*IGB      4-way @ IGB    none           supported
> +   5   3-way @ 4*IGB      none           4-way @ IGB    supported
> +   6   3-way @ 4*IGB      2-way @ IGB    2-way @ 2*IGB  unsupported
> +   7   3-way @ 4*IGB      2-way @ 2*IGB  2-way @ IGB    supported
> +
> +Table 9-6 row 6 is legal per the CXL Specification but is unsupported by Linux.

Exactly, unsupported config as described above.

I am good with the 3-way section above, though it just reflects, what
the spec describes and I wouldn't be that detailed here.

> +Walking it from the root toward the endpoints, granularity goes::
> +
> +  4*IGB -> IGB -> 2*IGB
> +
> +which refines and then coarsens.  Row 7 interleaves the same 12 endpoints at
> +the same granularity with those two levels exchanged::
> +
> +  4*IGB -> 2*IGB -> IGB
> +
> +which is monotonic.  Linux programs row 7 for a user region and assembles an
> +auto region whose decoders are programmed that way.  An auto region matching
> +row 6 is not assembled.
> +
> +Leaving row 6 unsupported does not prevent a 12-way device-level interleave.
> +The specification defines six other legal compositions, all monotonic and
> +supported by Linux.

Again, we should (and can) avoid this limitation. 

Suppose the following: This is a support cxl driver config:

4-way: 2-way @ IGB    2-way @ 2*IGB

Root ports and switches are configured correctly. Now, you just want
to enable 3-way which could be done without reprogramming the HDM
decoder (accept for the endpoints). Those configs become unsupported
and granularities need to be reprogrammed. This is very unexpected.

Changing implementation to use selector bit logic will solve this
limitation and make code (and doc) much easier.

Thanks,

-Robert

> +
>  Example Configurations
>  ======================
>  .. toctree::
> -- 
> 2.37.3
> 
