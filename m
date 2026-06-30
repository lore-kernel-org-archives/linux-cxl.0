Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694722A817
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782788241; cv=fail; b=KBA9TQVsm2J8qAKcayyJE7xmOk0ovAJw+xVUP1wj03mG0N2NidFzOs+ysaGH94ARw7fK2UlbMlL+z9qo9Evc+012UHex72IwUFCI8FOJnfQEI8OmuzOz6KABHl/df5lxFxNxNqzlXS7/t/3kicIkfZr0rLX4kFB2Ybo3Jxb25AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782788241; c=relaxed/simple;
	bh=1geIeZUcgq3wq2az8uXFHDkI2OibzEwi+rBLL8t0a2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XcFNoFG5VTc+Kw4Sw4h4P56bX3Eb1T/QGZneE20gc0G4Myfn1t4DdTUEinL/H8HnHOZw7hFCbIYoAfej/j5AO2/RKD/GXKMYxHPfUVYe0IqAXa0IXRW48RXA6rJ2K+qDkXNqWWa+SpFSxQyiSmVqeBxYq7hNacjOKLdnx/hCgJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h1RqqXJD reason="signature verification failed"; arc=fail smtp.client-ip=52.101.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h1RqqXJD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trEm6jf3Cbny0Ecklw16/ILwPtvSG8ZGDv2hIjJokFBNIkoD8q8ailGeufxS6WkxVtMOiYFhr7TYc8XlN9uGRzNoNUAXIdFZKYV7WunIaG0dC5ZkgeeXLmBgnDZ6SlgiUTih5kK2hNqdegMiZQxplF64nz0JBN95Q121A5bK0UH5A7bTToWzGCrwvKKV26DMRtweB2FxyImppM90y9HtFDpQdZyy7el69NPqjPdKYLWGT+8t7iDrHeUbapOU0fZzzwTcSHk98JenhshAzGauY1BkXr6qfWNfpeUQkILPOuJNNr8zI3lLJQ8dsETNQAGxVNkmUp0K6QY7TKsEJ/kyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbKipaJ0hvZdtmMeK8Ak6zv6mzsXLi1lIB+zJ94EXjk=;
 b=WtEZcEiVzKZwuh7qzw86cawCPNjF2XI7RFdYZwQ+op3bv/RFgBEx7wcortjJoJrQxLlksGuzO0ToJhAe4F0arFzk8CgOL51Ha3unvg1WJkXF3UOlKA6OMVo6pYL/yzQcySgRPZcOqL6ByS2ATm6Du3Ta7EQ0TKXkhX3HTxrmZRFPkXvC0WpV1MjsvYn6y/+o21ZDaqzt+lgGj1LExVcpTLak+6PphM7zKJkrwH2DSOiOZW6LFiAfJOJ6LCajuhNk46zRueJ/vuz5/+fQoIqt3Oi6tZ4nH92JulkcHLXCoRtgIAHQ1pHyt9ujFYjVjRDFs/EQ2GFMaL/ZhwkfW8XNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbKipaJ0hvZdtmMeK8Ak6zv6mzsXLi1lIB+zJ94EXjk=;
 b=h1RqqXJDz0SWqa3sSXWvjAKVsbf1nlhnpegJGIqovPm4eMh59imNvBRyVfhXuPR9kDG5U/P7Abc6Fyqd6TPu+oVSiYzCOOjAHLsYOJwUl1j8agpeneVXaV3w5f04a8MjgcqoljFEJXdEXDrH289jGIVsPON+S15sqFha2NNz7ykPovE0lg5UEahdQcE00h/xteecIewNId3NfJFWMIe02bQefmD9a5nskyixi4XV49FFjOylq+IBJKfyFkj1PXtyHAVCM7rUNBSz6hKC8TP1qmU+yJBAAD9yyrbw1HQcZ7xPevB/1E84tLOExju0KvngmJXO1NwUjtyAnklLJHMWCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com (2603:10b6:61f:fc00::622) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:57:17 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 02:57:16 +0000
Date: Tue, 30 Jun 2026 10:57:08 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 3/3] cxl/features: Clamp Get Feature output size to
 the remaining buffer
Message-ID: <akMvS64DmsltxxQ0@MWDK4CY14F>
References: <20260626104102.53892-1-icheng@nvidia.com>
 <20260626104102.53892-4-icheng@nvidia.com>
 <20260626105255.D37A41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626105255.D37A41F000E9@smtp.kernel.org>
X-ClientProxiedBy: KU0P306CA0031.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 522aeb80-a30a-42f0-3906-08ded6534b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|3023799007|56012099006|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	wuyZpHbjbcimfhu8eDMEooYiR4m32Pb15ztFk1iWbdG8rj153izBB8SG4Q5aWF/rhim2/ozAVBpyqyZDvnk74Mv/+l+RCRCUExUjbk1lm9z7fymSeKxMJjtzuSrdkWKsTeqzA7O3I5pxvuDapKZzZFAe89jRypQaUWCAuicYBR6RL3prCoD0P5TiDjzLG0Rc7rVkubf5SWictl34DzzKiU1Atrtqu24gtpcYjlG6zRiQWoj+x2m3my/vgLyF7FikWIA8hDoHk3OgEohfG1KwP8gNjtL4yAFkrnt01lTyeJ8ZrFeNiX3bKjVdBvljr7YwUvcLhjU141Vnw/w/ayG27bNZDXAkKK+/M4z8HGdbWHKmKPA5G39oV0pxBLgXB+bJXGgoYjGzfyQlL+GQv5/Oql0VfZYeomg8alv/FcPRn7MAHQaXs1a3is83VgwqGlyADdG0Y34BIXyJ9edVscJ92WAx4Uz6l/stCXfl3SKCJ1aGPufYX6jbaoToDm+ENoYuiQfhS97B/CMLTIxovuwR0calsuSZeC3I206Ki+eQ/bMSAJLoFW5N8G3pz7xkxrrULQ9cnTtEuM44iGotQCtYZ7rp4txgKHIIFetwnHtqhQio1YwwPeV9EGeIXMXW7rie3JcUWlr3uM5Xg3Iszn2j+zmaWoDSDPmc/7o6wJf+/Kw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(6133799003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?3iQ+jL1G/Jl7LVFm7WIIlXsqFGzRed700RgT1hNXbG1aoPq0DVkTLrZCc8?=
 =?iso-8859-1?Q?DzATdgArTI3zJUX1cPLR+cDh/LOcSQHUTPzCwntfz508E5Et5AflQ4/wPn?=
 =?iso-8859-1?Q?dKlftKeD7foJq/xArTxBbvqQZT5p7yWfPqnJEdWN1+pJYkDzqIisaDBQGH?=
 =?iso-8859-1?Q?tJXkW/wX3bS/3NdBqkslySEL+PVGgYbaP/d83qiAEYQfvKORdfgl7DJV1n?=
 =?iso-8859-1?Q?p3u9GRFJ4vi/RQXsKfRN/q7nH/aepJnKshK5WHXm3P3fLApxr8iE5yeEMe?=
 =?iso-8859-1?Q?dp5bIj4gHAv4ex14FxMuY46mBmbPeRoPRoVfCv7LOE6oBM4MnhVrSAHVNG?=
 =?iso-8859-1?Q?6mFjWby7PW8b+Amg6oOaLP+S9Toh5S2uJHcj5PTsu6H/ekvQ3F6oNGlGch?=
 =?iso-8859-1?Q?yNkhynADGSjE/m/cwnFbt5l3vMRxOEs2bB0osrG18r0YkjdhoCKne7JzJk?=
 =?iso-8859-1?Q?DWHeMmNr2xSwMLa5AgAqyV5osR5RMbtlFhDKjj/y+Q+YKmijCYswuC+H+I?=
 =?iso-8859-1?Q?ALz98ymBGHZnJcJ5kMoI53ncUyNJTxDX490YVHmaDBu6h/xa+UNHqxIAWw?=
 =?iso-8859-1?Q?7esZe4NRTYfxwT1WUqOKXZYJzjFDIO8zMH0Ri7FtmvsjvNK8OOdZLxYkdJ?=
 =?iso-8859-1?Q?aF03BKed/FrHbhojUReCsFOhpTWuI6Phie30Qdr5AnG+VbUhxGOJsGF3e+?=
 =?iso-8859-1?Q?uTalo+cNYLExmwKjD75FWRYNXNUe80JQN4BYtZ2cWFWv+PV6bud/zsIHJV?=
 =?iso-8859-1?Q?xSq6OPq9XN10oJR1ygfL1d2MTyV+tGRVu34UZCpB34Gvglesx9KyoguEpy?=
 =?iso-8859-1?Q?XdtwLBXnpf5pYkSUfHxenDo9u5+ZUPCigq2bMYVO3ftRpAPwS2+5rJ7zQ2?=
 =?iso-8859-1?Q?uzmgWexrqoPqzJx3H61v3JKRdcqqwGEhSGBE6e8utWfE7jf3dq5UjB92W+?=
 =?iso-8859-1?Q?virMXNrRWtIW4qmEDVZ7D4ac30xKcWKOhVlubFgzNwkRD/r7RmbdoIPAE4?=
 =?iso-8859-1?Q?/5CQe8AcqyoT551LQm69C6YzgT7TaCaghJItsSUNiEpLzpPCjQuA/6KyXg?=
 =?iso-8859-1?Q?G636isO7EL83ghi6CVkCqIN2sxEI1pZwbEOBo8QXajGZTXBsi8d6lB3K0v?=
 =?iso-8859-1?Q?xK/6MgHH07wvXHK7lxV/1EisM1XJ+7Bh0F/cPqN74eyRz+SkGu/CewXo98?=
 =?iso-8859-1?Q?YBqwHigJ4pOA3w6QOSGBBel5xJiMJNvsAqu6HFnOHKiYll+b+H9OQnhVl2?=
 =?iso-8859-1?Q?dPvR2JUL0ehhFETo3IxzqGwrPj7sXHMgwokFzgYpL+GslYqB8rj2B+rUS8?=
 =?iso-8859-1?Q?6/zaGSgPGq9+3Srcis0VuE92WoOHtoqOZCOwrbyO0mzZ9nH3aVbuzDw87L?=
 =?iso-8859-1?Q?0wtHG8hiDebwZlp0aRtOXfcVIBlxtRn8ByY3kB/X+xdHc2gjU704r08aVS?=
 =?iso-8859-1?Q?UiOgD1yc2hCIXYncDxj5pEHxkGpD+euk5K+tSDsz/uAAgFtfv8XboFeYu4?=
 =?iso-8859-1?Q?2rc8gLKxbfUN/ek/QQGNP/YoRmZnBjkqocpxOBVZdJ4WuSmdxlt9s9Xa6C?=
 =?iso-8859-1?Q?oQnqFvj1qvyxlJNMJCfRyIVfW7d48qx9qquMlodj+BDek4p3CKseLqvpL8?=
 =?iso-8859-1?Q?S2ixSgXqKQ5J3gNMXeXuUWY5BU8pRx/oC2En/fseLjDX0s4LBmo6SBgXlx?=
 =?iso-8859-1?Q?GiOK3FacUZUXjLTGx5gu60Ls0iksd7b0nr9maV10NtN7niUHma3Ivnzp3N?=
 =?iso-8859-1?Q?yCr/RJotiJ7uz+RxxrrBJd3oIRUeVZ8S4gp9XJa9AST1tF47Xbp2ZtQ3MB?=
 =?iso-8859-1?Q?9Ji678mqhw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522aeb80-a30a-42f0-3906-08ded6534b34
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:57:16.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDurPBKTsfziM5rl3/r5tJ9Dxp/s+48ePuFgikQvmKCi4tPA0PjkI2Rb1nv/K86789lUFyfV+OfO5zb4driK6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859

On Fri, Jun 26, 2026 at 10:52:55AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Silent 16-bit offset wrap-around in CXL feature commands allows device state corruption.
> --
> 
> commit 55606972e1fe115ff716307a2dad0a662361b0c3
> Author: Richard Cheng <icheng@nvidia.com>
> 
> cxl/features: Clamp Get Feature output size to the remaining buffer
> 
> cxl_get_feature() reads a feature in a loop but passes a fixed size_out
> as the output capacity every iteration. This commit changes size_out
> to use the remaining per-iter size, preventing a device from overflowing
> feat_out on the last partial iteration.
> 
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > index ed18ccb5e236e..e52371f873006 100644
> > --- a/drivers/cxl/core/features.c
> > +++ b/drivers/cxl/core/features.c
> [ ... ]
> > @@ -237,7 +237,6 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> >  	if (!feat_out || !feat_out_size)
> >  		return 0;
> >  
> > -	size_out = min(feat_out_size, cxl_mbox->payload_size);
> >  	uuid_copy(&pi.uuid, feat_uuid);
> >  	pi.selection = selection;
> >  	do {
> > @@ -250,7 +249,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> 
> [Severity: High]
> This is a pre-existing issue, but does pi.offset silently overflow during
> the loop if offset + data_rcvd_size exceeds 65535?
> 
> Looking at cxl_get_feature(), pi.offset is updated right before this 
> struct initialization:
> 
>     pi.offset = cpu_to_le16(offset + data_rcvd_size);
> 
> Here offset is a u16 and data_rcvd_size is a size_t, but pi.offset
> is __le16. If a user requests a large operation through the fwctl
> interface that sums to greater than 65535, the offset will wrap around and
> truncate the value.
> 
> Could this cause the device to read from (or in the case of
> cxl_set_feature(), write to) the wrong offset, silently corrupting hardware
> feature data?
> 
> >  			.opcode = CXL_MBOX_OP_GET_FEATURE,
> >  			.size_in = sizeof(pi),
> >  			.payload_in = &pi,
> > -			.size_out = size_out,
> > +			.size_out = data_to_rd_size,
> >  			.payload_out = feat_out + data_rcvd_size,
> >  			.min_out = data_to_rd_size,
> >  		};
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260626104102.53892-1-icheng@nvidia.com?part=3

This is a different one , I'll include it in another series.

--Richard
