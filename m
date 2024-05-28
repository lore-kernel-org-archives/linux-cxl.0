Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2139.outbound.protection.outlook.com [40.107.100.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB251DA4C
	for <linux-cxl@vger.kernel.org>; Tue, 28 May 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919847; cv=fail; b=bM/FaqzcqC9WoVFQKilWkxWD9SGQy+BA2hu4IDymuFxVLOe9VwKSmg5pZ2hD3RCHH6L6HB+YzgcSlhm8T654CKzQOFiMRYn2aXVBTYwWMVHxZbrqm9dbr/ePTKjrPR9NiNLHMrDQf8NEk1spILBkuygUzCq6VxKGW3IveLi5lmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919847; c=relaxed/simple;
	bh=RDc4BEpqtbpJGKMrGgeL3+KEO39bTlI7Z02JSvrtz1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FtCvU7rD4fbXlW9NLDNqmAgijlbTVdckUx4XQHohh6nUuDlO3FRURYYFgGCtysAZ24RdyjitMYb09VXmd2Gm9VJ2SedD0xXpQEpDeKgZHdC5oCBSzwq5QAGyf9Beac89J+NGVrAf5Bd2ei2Ujky9MKLgz/FkjG0q3d8gQd05974=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=fail (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=FXVdWbQv reason="signature verification failed"; arc=fail smtp.client-ip=40.107.100.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="FXVdWbQv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EahumtyyNdlCE1O8qZQgOoiUscTmd97HOb+vPYHTh3hxsnZ/AdW8BBsiNLa451IUaTrYR65GXbjo/LtEpID3eDulLjBOiXrlJUIFUnBkHof0ZB2kSGtVI56pDexy5JiQU7SKgodwpa2NXAKSNx8o9MYTCF34JFqXMT/Qu+m6li8IS/wH+JmlJ+09FN+eZLAh+KVVWgNiunUak+PXFQUSeWylC0Q6AGjXeV29K2cPVDcpPsW3jQJDy1GFEFjBnocFEGeJ+gh5Jcmd7rJqDSp+/i/7AjUXffn/1bkvlPeTVVVr2hCItNAa0fazWIDb7BzqlaPdQnMVy8X6x9h/aQ/J3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDsRMRe7FDEmsYLQx8ZZz9TmDd2NHIBuTpBzOS6jPDw=;
 b=IBgDWJ3dG3XYOhW+c9ShazB/KDWhoC+d+85+fRNsjxEUxbrmXrN0E6IH2PK42F8CI5mFIArNqMI/JVTjuf1eGC55CrrXQA4hRFyrC/OY5ceTgWDjgajiM+UFHmPsv+J+JMvGXSizbEClEmKxImOv00HRoud7YZ3og0TbXnWgLIidZpQqTCTFSM8FYRjM3sSbaA6q8xzX0ce9YyzwA5xs/G06w+L11EVEb/Z41vP8uMcRTBM9UnpZwwLxzyQNIj9qgYkvuFzudP0hQ0Quw/jWBdYjfHQ7xGXCZvEt/quIE1sKTJP1FrocXghMESDPwTLHpWqBSksFbxTn8evh6lHFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDsRMRe7FDEmsYLQx8ZZz9TmDd2NHIBuTpBzOS6jPDw=;
 b=FXVdWbQvEqo5Imumsh6W9ODz6frfILLCB0r4qd0C0/PBljUkrQ8nz1ZUtKcK1qNnqm9N9qE/69nZfpxv4jtYg3uxuP3P//3B4se6hko9OY1J0bYXCyUGvtLoTu3Dbp0N/amwMJW2vMSp0CK9ahTYr1hvRkvnHdPzVE2bFYXNffk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH2PR17MB3864.namprd17.prod.outlook.com (2603:10b6:610:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 18:10:41 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 18:10:41 +0000
Date: Tue, 28 May 2024 14:10:33 -0400
From: Gregory Price <gregory.price@memverge.com>
To: fan <nifan.cxl@gmail.com>
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	fan.ni@samsung.com
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <ZlYeGVFJZaHq70NG@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <ZiK25Log7LmtBffa@memverge.com>
 <ZkY83c9PXoop_r1A@debian>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkY83c9PXoop_r1A@debian>
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH2PR17MB3864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9335ec8b-5a71-4a4b-1e03-08dc7f417bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?AAC7ck7Cbft+ywXJ8BJDzOeUMZfXF/6atN1CDoaw3Fo0AgCwNZyeBB+7W3?=
 =?iso-8859-1?Q?NerN2mHz8rDytCQUD6GtDDyXuowO4+DTcW9AnwBl5h1es3ElGaQW83xMo2?=
 =?iso-8859-1?Q?JXtJaX2p877W9UBElk9Hd8LwK3Sx1fwX/wFChHGitplYYltUcZuoobaO1U?=
 =?iso-8859-1?Q?CJ2NEzQG49uBoEf/aBi0d9eHoBs2IJuHvL7or9Ee/v7U7iMFo606e5vJ5S?=
 =?iso-8859-1?Q?ffxsht4EYsyZ5SqQuXBYu/H+PbcQQSl4NQqq+YivzVFdMmCvWlDCntZPZz?=
 =?iso-8859-1?Q?19rtFwrbrd/1B22/TETWfjZj8j65D4pbjgJ3OzGWl4vYLmax/AYKg6/bwJ?=
 =?iso-8859-1?Q?PklhD/i2ZSVcslwMeTIj44g7qIkHYbNSRevqcpd7UuYbCXiLQQ2tK+AaFU?=
 =?iso-8859-1?Q?GoKXmR2K5dim1Soycdpq6RrSCNoxrlIxce5mqJ9fmY3W5iqBr8zvwO1kHt?=
 =?iso-8859-1?Q?yPcBFknPeORT7C8H/Au2gkuvtoCj38UnX+YlG2n+T0B7DMPEuN/EmqV63y?=
 =?iso-8859-1?Q?A/kpX1GmEqYkTGkme6Gxgj6R5Mgw4Prq8p7oUkXJQ95qo89Fm6Q49fjHqT?=
 =?iso-8859-1?Q?CWNMvv4lWTzKrKaADG6zzA9Mis2O9rUGLCx37jDxIDig57IXnqDEcnTMyl?=
 =?iso-8859-1?Q?N5n1ZJ0WMeAgJdT8imTuuQmj51+tg4JVhCPjn0QKcnHyxa06yw84rfkGwX?=
 =?iso-8859-1?Q?5N14at52IlvCDy/7ZPvC3Q3GIpICY08QYvuTvmq/zT2PQabTwLsNODcOXj?=
 =?iso-8859-1?Q?/r/pYKGdNC3MmZa3elIW30rwvOfo0lWgjGcMWfKGFFt0jZIsvCynAEy5O1?=
 =?iso-8859-1?Q?c+h4XGVwXUxBJDK2PpIRdhTtulPnPLG+wrv1XDQxV/FnrfV6i4E7Bya1fa?=
 =?iso-8859-1?Q?Qw/bRNqBbjOQ6mCFtV5WvilbWHKqm73frz5dnwwApaZIJZ827n3600hi+U?=
 =?iso-8859-1?Q?ItobEEfiPOcPxFc/gi2+joxyWFmkP+jJ2anckf0XyvSgOwv52hJHs9z6mt?=
 =?iso-8859-1?Q?Y06Q5xJ4sksJuL7rPl/aOKBWnPTIlns7jCdFLms+5YktcGd3nqwq1rsIbV?=
 =?iso-8859-1?Q?erXRciRGis0cdT0qezNBxZD+8CagNRB98CRAhzor77yOLuUdJLycSUpFys?=
 =?iso-8859-1?Q?rh9gfMRw45huZeFRhBWua2ucGqwqmvnAGoSfY0BhtyzZrjVG5BkNtrDYHR?=
 =?iso-8859-1?Q?s1yTepQprU3ZQW0RaPFAy47CTYoAaDauO1ZsOM9fgjRmqMhY09b4CT42Ae?=
 =?iso-8859-1?Q?Io7txw8VS4C76/GEFSQy+o721rWLzmo8F8Tzz5Xbc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?FlT/VZ/5QxehSllyBU7J7k/5kqsMaxbWenXpEk07ommAWJXb3rgSrcKqH5?=
 =?iso-8859-1?Q?p3eaUwOv4k2Psz7oR+IPHn+WogxPMuPkWvyz1hQuOeobjVlCibCSiiY1f+?=
 =?iso-8859-1?Q?Iw3AK0rTKnOgTHnkx4e7AOBFE+XusLqL6MLUqF6tMrf6NX8W69HvUAaObT?=
 =?iso-8859-1?Q?Q/ZFn/xu8GeDeLSBMkp+Aw7Fh2sHdBd9Ql06F8fQMdTGQ+b68VbVGYh5iJ?=
 =?iso-8859-1?Q?HBVq9zKurOx+le0vvjjzcAFmr/FibDSmijwwUlEz2VIjJ6KgFgl3FsG2Ig?=
 =?iso-8859-1?Q?FRFp2DIaSn4jVxhfj0h8e4ySINRVKbmafdtfDl7hWGyeDbsPiPIKoY6Xbl?=
 =?iso-8859-1?Q?P4+5gpwWttrUSeG4hQGmFe1CD5UU5tHgCRqx1hDFY3zZY6ZH+11uwj7bQH?=
 =?iso-8859-1?Q?RpLyAMfzZGUizCNulyfeiP4RM6JbsqG+ZiSzgoAfJKZWtx+9nljtOWvpFF?=
 =?iso-8859-1?Q?qJjkt42fjqkbDVT4R4q2fmsne+Z5U85hYySSnUnp7pvhYlPt6V6lL+CXZG?=
 =?iso-8859-1?Q?eeMXaFGjZ6rjCIkpJaH86Ujr45nXumfa8lDE4OI9OM464RRul+j/KeDw7U?=
 =?iso-8859-1?Q?uxQ1QBS2dshBJocqbyhPKaDfcxsHZdTwlUe3ecc58+gBgnuZ7huaYrfQXV?=
 =?iso-8859-1?Q?9KzT13Ao+5bWekmcRltwddT1VHUvOfmhG6TuRKwGUdmqfvHua/0xfVWNHx?=
 =?iso-8859-1?Q?jw+hq4oZtsY5qThhoIge92nNS+h+kZORU4KjrVUafH5D6vFpu2KLXB63ps?=
 =?iso-8859-1?Q?CVYuKEG25UapAZyqJTC9dGkokpRaCtUKPah5mhzOef8P7QXc/wrAsfyVXC?=
 =?iso-8859-1?Q?uRjc9cXTxwWnJ5zklCOpzHjkKYgA62uLakWfCvPB6tfRl54wmJ2gTD5wsi?=
 =?iso-8859-1?Q?1JVRUhuPvo6SgY4knDFJLLnlFo9jV+qqCYi1Tlz+J5vJwhfY51sbZ3K5gP?=
 =?iso-8859-1?Q?i89nAxFGTaq3oxVnAaThWAXR7/21AVxprJJ+ANfkwTX7gwjYThfBiDNFDc?=
 =?iso-8859-1?Q?BcIJwLRThWtfgoleGgb/Rryph+4iD06b8hrsuUHzl8Zw8B9VB/52B6Xr3L?=
 =?iso-8859-1?Q?/aZqnZdK35SS1rNacSZ0GPYj3RHRt1g01YXiHnIQbIww4uR8DmzZXbLweQ?=
 =?iso-8859-1?Q?OxeFmRskFkyZEkVrI2L8WeTjAHWOqh7T4aT1kidU9YUwcZLo2+wL0Lwzhe?=
 =?iso-8859-1?Q?cGBtVOGI+Vv6aX2YBicrHWNmrJNUBVHZ5iYk+c9pHNx9k4bxLAi2sLS7QK?=
 =?iso-8859-1?Q?h8kx/4x7/ek+WdoWt1bRb9nYK1vnFBgk1NGuRORKUcSkVpXkVKQVRsyPra?=
 =?iso-8859-1?Q?mor8Ih6FVBof4qG3ByxchP6xuUS2qePZBxIZMSWrQMRPdzWvlJZn6qacMv?=
 =?iso-8859-1?Q?ZgxzUbPDwWQ2962pgBxoxuVj2SNS7S+bz/8wABIyBJbAorTvZOncCxLBMD?=
 =?iso-8859-1?Q?9gCRYRjKbf7+gPMP6TmLyxH4cinKOiTDibagolqvycnCxEH5ZEWeKcj21d?=
 =?iso-8859-1?Q?tJT0/DNo7XLud+5L1qgpo8LQEIbgJ6QDsGxPqUk5skXWQFS+89V6pfJPFO?=
 =?iso-8859-1?Q?J+NwNSPw0EH+5QUljj+tVCvDTDez+8K6rq4O4MXVUIIiMOM0JJ4rHLT7PN?=
 =?iso-8859-1?Q?Ch7wv5x1AaBJ5BSlCdWhI1/DtMiovLtdu72Pr4pK3OS0/2trAtLHi1Ig?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9335ec8b-5a71-4a4b-1e03-08dc7f417bf2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 18:10:41.2593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQnFctqPdt+0kxcG+CG4ANZbYAW/XJ/2LuDzW5eimpsKfn6mwceev34GeNk8yWHUBPUihu2JD9OroHqx6H5pL7UTLCgYokSwclCHbz2+MSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR17MB3864

On Thu, May 16, 2024 at 10:05:33AM -0700, fan wrote:
> On Fri, Apr 19, 2024 at 02:24:36PM -0400, Gregory Price wrote:
> > On Thu, Apr 18, 2024 at 04:10:51PM -0700, nifan.cxl@gmail.com wrote:
> > > A git tree of this series can be found here (with one extra commit on top
> > > for printing out accepted/pending extent list): 
> > > https://github.com/moking/qemu/tree/dcd-v7
> > > 
> > > v6->v7:
> > > 
> > > 1. Fixed the dvsec range register issue mentioned in the the cover letter in v6.
> > >    Only relevant bits are set to mark the device ready (Patch 6). (Jonathan)
> > > 2. Moved the if statement in cxl_setup_memory from Patch 6 to Patch 4. (Jonathan)
> > > 3. Used MIN instead of if statement to get record_count in Patch 7. (Jonathan)
> > > 4. Added "Reviewed-by" tag to Patch 7.
> > > 5. Modified cxl_dc_extent_release_dry_run so the updated extent list can be
> > >    reused in cmd_dcd_release_dyn_cap to simplify the process in Patch 8. (Jørgen) 
> > > 6. Added comments to indicate further "TODO" items in cmd_dcd_add_dyn_cap_rsp.
> > >     (Jonathan)
> > > 7. Avoided irrelevant code reformat in Patch 8. (Jonathan)
> > > 8. Modified QMP interfaces for adding/releasing DC extents to allow passing
> > >    tags, selection policy, flags in the interface. (Jonathan, Gregory)
> > > 9. Redesigned the pending list so extents in the same requests are grouped
> > >     together. A new data structure is introduced to represent "extent group"
> > >     in pending list.  (Jonathan)
> > > 10. Added support in QMP interface for "More" flag. 
> > > 11. Check "Forced removal" flag for release request and not let it pass through.
> > > 12. Removed the dynamic capacity log type from CxlEventLog definition in cxl.json
> > >    to avoid the side effect it may introduce to inject error to DC event log.
> > >    (Jonathan)
> > > 13. Hard coded the event log type to dynamic capacity event log in QMP
> > >     interfaces. (Jonathan)
> > > 14. Adding space in between "-1]". (Jonathan)
> > > 15. Some minor comment fixes.
> > > 
> > > The code is tested with similar setup and has passed similar tests as listed
> > > in the cover letter of v5[1] and v6[2].
> > > Also, the code is tested with the latest DCD kernel patchset[3].
> > > 
> > > [1] Qemu DCD patchset v5: https://lore.kernel.org/linux-cxl/20240304194331.1586191-1-nifan.cxl@gmail.com/T/#t
> > > [2] Qemu DCD patchset v6: https://lore.kernel.org/linux-cxl/20240325190339.696686-1-nifan.cxl@gmail.com/T/#t
> > > [3] DCD kernel patches: https://lore.kernel.org/linux-cxl/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/T/#m11c571e21c4fe17c7d04ec5c2c7bc7cbf2cd07e3
> > >
> > 
> > added review to all patches, will hopefully be able to add a Tested-by
> > tag early next week, along with a v1 RFC for MHD bit-tracking.
> > 
> > We've been testing v5/v6 for a bit, so I expect as soon as we get the
> > MHD code ported over to v7 i'll ship a tested-by tag pretty quick.
> > 
> > The super-set release will complicate a few things but this doesn't
> > look like a blocker on our end, just a change to how we track bits in a
> > shared bit/bytemap.
> > 
> 
> Hi Gregory,
> I am planning to address all the concerns in this series and send out v8
> next week. Jonathan mentioned you have few related patches built on top
> of this series, can you point me to the latest version so I can look
> into it? Also, would you like me to carry them over to send together
> with my series in next version? It could be easier for you to avoid the
> potential rebase needed for your patches?
> 
> Let me know.
> 
> Thanks,
> Fan
>

I apologize for missing this, I was out of the country for a few weeks.
I'm still catching up on the work history.

I think i saw in passing that you picked up the CCI changes, and those
were the ones causing conflicts - so that's perfect.  I can always
rebase on that.

~ Gregory
