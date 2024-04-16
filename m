Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2134.outbound.protection.outlook.com [40.107.93.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3657131E21
	for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287669; cv=fail; b=srivuV//shzR4+9+m74QZhr/897VkHIpxr/EfaIK9bZxwIOACsVe+NNlH94lJjaRpCiriHNsrSq5m3aGM15YB7yITqzy8RQ6Ey8Lcrqu+yPGq2aJ5CEVlURiRncKRjGwTGlGbbf6+uc8QXTgMTjFERQ48uL6qxF0gWK98MOSDUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287669; c=relaxed/simple;
	bh=CMjRFqAzeLIL4fTz1IFGViR7t466VgYdGVqOanyKIcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NzylyDfj91MRBIExnAo97s0nqh4XDpbn61EPzfsjYksJKshcQbrDsJvsb1nww/tj5rM15IoLUDOb7xUTMAk+PqRCmcN29Mh/6qisKXBrUh3lu7M3YES8i1EIGFH7qBR3MxQjhBQe3ZEH0i4Xs+DikAJ+MEX8WKF+K5EoF9t6ZA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=wNZoes7a; arc=fail smtp.client-ip=40.107.93.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="wNZoes7a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlM1Ifz0T9bRVrBaf9gm4LJT/Ms8CmGu2Ih6PRwRmWOi30w9h6k1H864aYU6Wu9dIQsafh2CYPP9WttQh3DtXoqJD98hd6IyMeVuM6CnIQMs/+GOOg3J8JZbM/S0ULtWjAq4n30tUayvHL5+XhhAe+N4LNd913uaZ+P6GLyA+ccfYQO8Sem/yLRmoOYY3TA5HO++MqGXm078S/NJmpX84hGSBKsU6gIQSt4rZOmUe+jc8LT2PDQEeg3mGx2JbVhtMQvo0kL1NlLP4eXTyEa1tfjaZvW8IIlYD8OF3Mlz8yhBfvPfeR/wpg0jPAbJSSbRMn7p0YQuaTfDlashkniY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmVFVUZgdR/Nwhl3OwT2kyFUjvneYgH4uk5ygUMMWfs=;
 b=FX+55XZg6CViCpjpZmVMp6IqgZvM2GbXuxYsrEgy+eLhKSsbpqMcbmqau1f/8zxTDDYKyCV+hUm5UylUkc8b63zAxuYktRsoePbmewXTaYc+TE5NO02j3V5y9FFdBrhcec884ICi2kxMRGOu6J9Tf9Ah0Gqbibk+0kV4DgpVoCzeo16U07oigS1zJ9/vz2Fte4QSzR3L7bZ2Jzww3pF6lbu5Q3lYwT4QT8RLMGn9aoW0VLAuSGlBuY29bEI+0CFVK6YCPyI+AGSeLQq88/AiArPe64pdd6zlFz3lX6l5SwwQqPFIBJTgLONFOWJoXefZGGzaUNsPZK8Z8foLykr9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmVFVUZgdR/Nwhl3OwT2kyFUjvneYgH4uk5ygUMMWfs=;
 b=wNZoes7aRWB9Sen/xyCHv1qTpeSFRD1jLFQE8F5YmYwwtgXVP5Owttm7vmFWStEHYgtQheJAJaZYGBIay8530bWeF616BmRCsMSH9gIaD1d4e/j66Iq7a1Yr4MKUCGBlaMRvQzwFSJw1FMUbnJRSZ0jaG+m7plcV5aTZ6l7pMvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH3PR17MB7146.namprd17.prod.outlook.com (2603:10b6:610:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 17:14:19 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 17:14:18 +0000
Date: Tue, 16 Apr 2024 13:14:09 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <Zh6x4ez90qSdfYSw@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-10-nifan.cxl@gmail.com>
 <20240405131856.000025e7@Huawei.com>
 <ZhWym2yHoh6YIaXj@debian>
 <20240410204911.0000590b@Huawei.com>
 <Zh2IrA8TQDJn1ft_@debian>
 <20240416155822.00004fce@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416155822.00004fce@Huawei.com>
X-ClientProxiedBy: BYAPR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::46) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH3PR17MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 1048da73-ad02-432d-c87f-08dc5e38a6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RJOipMv7jroxtk0tw3sbn4DNaXqIQ0ts534BMKiPLeFRkJxPDZw1EgB8pqPfMMuDOhil4aX94L7fFrOjFZLK8XO/ESIrG5TYkIoAeGeRDG6ojH6eRy5N3NPByPXZlu9zJPhgnxkhUG4aEALQIrjyAV28ugtw156uHNtimCXmeKts9PuQitqBbJRRe41NNt+v4dWVGg2Ndiku5m3g1KFRsYHsEbbyBXB6ZschWqbTaS/1i42OiFJR1lk9QNj+eVP7Ftl1eErfJtWn3vBP7kgr5/GCZdbiBuRk7I1KWkBTEf628seTOQ2Gye3Nq4OVIvIXjQoUT+64mEHeqVUQYtBYTSfeEMZAcm0yOxhk4jHhwm3HnHLDBTDyxwB9YlOi9f1gJryVlGNC8ATEVQFp2EXeN+Iw7QqARhAsulDoEOpt4Tg02vJxEa16kz5zfni3OrD8PgoBRcntd9BEteuZOahLWydES2V08XB7Qwpm2M5thp0AKWgif9rtz+t35MgYQh7uq8QbssbhlnhnKNAHuJ/o9nBVr1zZQy8+weRvx1fCB+KscgLNcKEvyzPOxYNH2o+kmqRFZX+E5wUiIHtVeX0Jwj3Ttfzq4hw6J3rd5WhcSnegMGoE1V+pYozzJv4ODvScQpZBvBsN7DHulY5w98rHLYndKedezCrOrlTihzuRGMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UHv8qklifLYsoNjz/8rqkqQEp7yAWdogvveD+VQpTf/wIMd4MJXTCgyYYAy6?=
 =?us-ascii?Q?mSCUxOBELG+aNJkxm2OFz6LIR02krICNYqBEuuaob7waWIa2RfisVuwL5JZM?=
 =?us-ascii?Q?00rHRIUEK80Pv6N89BgNJCGBKKQAL7akbZRsJKDIfmFnkzZ6+v51x0eVyBLu?=
 =?us-ascii?Q?u88wlFdKS6FQOLiDMuBBVjalJVH89kdXPqmRrMcd+ym8CAfXSIFMcVikA/cT?=
 =?us-ascii?Q?ucaU/RCne/lsj0VieFb3k+cwdSyIozbzPxcv/F6BuvDkzXmSo44skeHb9TpH?=
 =?us-ascii?Q?h7zWqKL1qon+RZ5pNmGZeNQIe5lX4SNkMogtRpPUZoX5QZi4SL6dhK6S1OT9?=
 =?us-ascii?Q?WcicgCQl7Mpv7GlSvHi3BBphnjsgzxISMqGRnQrzl5EymHe4Ry5omJw06UTo?=
 =?us-ascii?Q?6s/gVWuc0w8zRDGMr4HHghkLQZvreQy2Z528cEtzbRFWiYtSIZefTpo26PKz?=
 =?us-ascii?Q?EmgnzWv94MnKg99GmEDYkNHAM607BW5ug3E8ew23yUdOGpmWGpX0jinxu/Mn?=
 =?us-ascii?Q?yJ9oN1S6Z0DzqJeeYf4QcTd94MblpfUfY4Rwq7NxEJiTEAwCWyJ/NeoocIrG?=
 =?us-ascii?Q?SVuZImVek6Dk+NMk0wUXeCEZAnVIiPOUZ/A2DBUIBDXZhL3Omlfd0NXb0iAk?=
 =?us-ascii?Q?EA4+OvDbS0c5R7mIzmKzjJkSKhvxbzee7VYF7Wn2c7IVg6rSQ3Wgk5W/mKG2?=
 =?us-ascii?Q?62OpMuEsEA9n+bv5qeGZ/5aGNIvmGPuGzvI3vBn4xzF5YBQGTmKQbVhrAWSH?=
 =?us-ascii?Q?d8ejCS2c87DC5cebx6A2ERzkRSJua2HSTekqZt5UvD6ts1HoQFCmsExbbJPF?=
 =?us-ascii?Q?nlJVPknnhUq3KupCOsXtojs24CoFrOp6KlMotZe1oR6ROKibXiUGkIVP39Bb?=
 =?us-ascii?Q?KB/UsZleI8kFl2K4PpqUnE/koMS8EkgV11yGCHIvN0XKOjC1+c24j/fJgH6p?=
 =?us-ascii?Q?O1hXNZHbVDK/rr9Sa9uq4zxGggXIXw16WcSeBs8mnjeuX8wKbm4Q7BycfraR?=
 =?us-ascii?Q?JDL+Nazuu/jnmE+4DjYB/wMonN6F0FFmIhlwUGbQniLTk41ZuXsi3kXq6PiT?=
 =?us-ascii?Q?nD/0WFSIRtXBqCLMKqafABk4ftXmVQ89kuZ+cgv6CbOEipRAUQonCPXdjBz0?=
 =?us-ascii?Q?FNKHFOWRqy9xAKNQYXdXwc0E6nj6ia7RRCuwzJHplIFTN3Q1Lr+Sfr23Kbeq?=
 =?us-ascii?Q?1Xwp2z2QQp1LLPzcYdRCuRfHnzW0806d0JbDaa7LRKDWS4niz8CR+VipnmhV?=
 =?us-ascii?Q?GRjbfua/3eVvHEI9wCWknWYRt0nM3uj2PGDJwEaDHNR+kc501FqraMg+z6kR?=
 =?us-ascii?Q?iIj81naXK2JYaERbdQbX0R6uGfv4/xv/rQIOLxQG0gTSv6bBoDS+6lZxB3Av?=
 =?us-ascii?Q?jJGXGOnMKC3DIPoFT8q6X8Os9M6SkhzjjmAFzlJ4wAaq7/ewADmKt+hv7YjI?=
 =?us-ascii?Q?IZEKAXYwANgBKBkDqoNuFRVNMHoVkeG9VVFOvFcvwQuk6nCndZKPjM+IUjKe?=
 =?us-ascii?Q?w7Vnc3di1lvXre4/+aFWi8WAAH6hsc67y5iAsrbjrmvMgnariOLZqervoFC/?=
 =?us-ascii?Q?mpBiK0p4x3A8mpnr8xtnFnSTJMtKebV75wxruyq067YGLna5gPzLpRzro0kZ?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1048da73-ad02-432d-c87f-08dc5e38a6a0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 17:14:18.8497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owPkKb8Gwr+Ma+kbTP+uun29Soll3WHY5zq+Ab6wJpOe+0A6T0743aI1Vhw8vYb/7KlG+hHOWybY7xFV0fB+0AD9oaVZyri+6AxdKa6i1F8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB7146

On Tue, Apr 16, 2024 at 03:58:22PM +0100, Jonathan Cameron wrote:
> On Mon, 15 Apr 2024 13:06:04 -0700
> fan <nifan.cxl@gmail.com> wrote:
> 
> > From ce75be83e915fbc4dd6e489f976665b81174002b Mon Sep 17 00:00:00 2001
> > From: Fan Ni <fan.ni@samsung.com>
> > Date: Tue, 20 Feb 2024 09:48:31 -0800
> > Subject: [PATCH 09/13] hw/cxl/events: Add qmp interfaces to add/release
> >  dynamic capacity extents
> > 
> > +
> > +    if (num_extents > 1) {
> > +        error_setg(errp,
> > +                   "TODO: remove the check once kernel support More flag");
> Not our problem :)  For now we can just test the kernel by passing in single
> extents via separate commands.
> 
> I don't want to carry unnecessary limitations in qemu.
> 

Probably worth popping in to say some out of band discussions around the
`more bit` suggest it may be a while before it is supported.

Allowing QEMU to send more bit messages to the kernel would be extremely
helpful for validation that the kernel won't blow up if/when a real
device implements it.  So yes, please allow it!

~Gregory
