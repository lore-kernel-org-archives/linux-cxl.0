Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BA01DFED
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148566; cv=fail; b=Bq3AYQC19kPCI0rnVyu+YsrrxlSq85YokJO0gON+BDKZF01nmVmB6B5RcSgaQLQNSNA6EGPD7qKtbQqHocYDeiyMccCDCFdqMZam6QjE1MzPQ2fRmTV6NhQKI5I3C6vQokcu2SNlgOj9Ux7r8t/3Y1dQNOA2J99h1NZsdievyUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148566; c=relaxed/simple;
	bh=bnHmlIZtkxzXtfa43WIEP6z9GYHPqhULvEnwPtIUDBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yfa8wyeN/KqDa6uXcDozfWIYGoJVRgvlK9LqEXYPcTfv7Ef1BsF9SsUkRJYSKNviyc0kuWBRc20TH3VhMRHG1tR6tnsKY6rRtEf94isvyeaaMLYqNoqDgyRQXdnk9keEa3yjSIcdkKEqY1mJ7l0FglVxd0n/oFjanKO9vM+vUvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=krCTLbRC; arc=fail smtp.client-ip=40.107.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="krCTLbRC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl9fmuQtA/vgzB6ci7yVZNR2phqsanFekVRob63Tm3V4Bh4WgFlNLIshdHkghKxeJYpHlJKKQm2xU5U2p654zEJmWUiLuAPpLxOPB+XRk62CBP7cbgbNiYO2YyodDnZSj/23VBtVS9Et2XSL5qZwWiZHoCWOvhGLiKLcykfMy0P89EbJB7D4x6I97ig4m5E5tKExpddBUaipMPlgX6Ao7Gy5dlKdlzLOK0K88Or3XJbIxmYnwFzY7Q56EJ+4dpxUoPambBkBylPDJcB7yCVgLD0ZAC0S5QHq5lJf3kV+1PkJAh3T2Co0Imp5UB8VOFIuylnlBFy7wjj+fwYRxdMLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkI0L+ILnrzeH8bcfjKEeQ99CsfrHrwiUCdI7di48hI=;
 b=ahVowKTCtxRS9kgUv55vR/wVB/hZIeLHuT8ES9lPLPmTvkBrLBtJQbWTAg6pztMG5oEtX+h7a1GX/YXsB1oUil4tIUGXGOOerIKtdfXJcZDK7n86rwhb2voiL9YjS0avzFMvzmvF2id/8QfF1jwN2ABI7xDi81CkuALJfUD2lIhWlMhyBSnY43RWXCYAepvLhmIEkp5AYMJwu5l1FC3PzcUYEibZJ5LEaQRErEtfH8C3g+DE40oDzeHGQxn5GqxLUM+VU+7R0t7HnS7A6d70Yoziy9pJDaclxn1F6dA2unbIqKTr9TI7aU59VDUzNr9M7byX64GMWklGA+m9G1+0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkI0L+ILnrzeH8bcfjKEeQ99CsfrHrwiUCdI7di48hI=;
 b=krCTLbRC1ROm5Sp1qFIeVN1DzExJs3K0mPWrhyrcx8xG6wiJCZkF8ZdKlKn/cZjgF3X8d4Odq53u2FG7YgIdCADTdvLSUL+4M5Xd4JZxlg63My8/3Kk6muWDEXyTFrkow5jgmcycL01eizWf6p398SNgiAqmNFB32xWEUMZ6q+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH2PR17MB4087.namprd17.prod.outlook.com (2603:10b6:610:5c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.48; Fri, 26 Apr
 2024 16:22:41 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 16:22:41 +0000
Date: Fri, 26 Apr 2024 12:22:37 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Markus Armbruster <armbru@redhat.com>,
	nifan.cxl@gmail.com, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZivUzfka2yOmnAUe@memverge.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <87a5livrdr.fsf@pond.sub.org>
 <6629426dcdbb3_e1bea294d8@iweiny-mobl.notmuch>
 <20240426165555.0000181b@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426165555.0000181b@Huawei.com>
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH2PR17MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a8fa55-99e5-4e04-fcda-08dc660d1885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q++exj/MYjfEvr/1qvjNw9NMjfNR2PuVIennpnudp+pBkzeteyxPmxZIdPeF?=
 =?us-ascii?Q?QU3IdSh1F74FkbLOXfUioqhkhDUDkM9C1RVJdyx1T75TLnIDVeuJFw0pglsC?=
 =?us-ascii?Q?g1aCW5m25/Esez4n9aw6CUhML9eoYcQ8O/oTbAGsDjPlaRH6yiTSzxY01uRt?=
 =?us-ascii?Q?NhiIJUNYQuwJqaIGHFN762nSeiRZ2cvcpYYCehmvaw/I4EsHWqijYGCeKXy+?=
 =?us-ascii?Q?U03bgx9CbpsXhnZN/xPIPaXcGOYTWe8mCMN8KtWjCZtJaiQkyr4a3E0xxiKm?=
 =?us-ascii?Q?lH97ly1ti0pd+Xk8eSnJhn0X7KGHDAzK8I6gsEtjBveEODYraBBRNWAuGgvu?=
 =?us-ascii?Q?OycqTmpdhRJCBJlZdMZW7BF9xPuvVcQ8AW/tp+TpPgFowaAKcad3bYzmY5ru?=
 =?us-ascii?Q?PX9rVAmQqdnPW578h82N/1JwwhGzq6J8qXZt/64eDktc0S2o8FvFkTXhOCxd?=
 =?us-ascii?Q?Z8zs9G0qypl8LOhzEMI6PQ1hNxFmOx54mov7hz8i/1S6TgFAw1xTmyt3oThX?=
 =?us-ascii?Q?f3dIa03RNi7rllX0LD+o5VJzGH2XkxZkeTJQzliZ1+vkiAMuhxiw1Ek1ww7i?=
 =?us-ascii?Q?TxCU+dS3GERH5mij5yu1y11FHK3iRZTGylg6U5PZbNpxeQtRJTffZUl05jds?=
 =?us-ascii?Q?sXfjo14h5XlKCK9tnRpBiofFUTIIsp7n8QJvBcuor9JZfHL58NY+o1jtsyC/?=
 =?us-ascii?Q?RCV+yUNdVZ2NWyQxat9I3JMUeUq14SaTx4vfoHis8/+4I74vYbIF1pbhgp07?=
 =?us-ascii?Q?YxQ3mGlp9o8OZnduMC39K2SbyQN5yjwAKzjDTeHRng+yL8G+/vLtyDruEUn6?=
 =?us-ascii?Q?zehrOlR7swQFQ3SwF9Ph7713Wdmnsim2+UwdN6iFDHsPan9dy16Wui0n8PtU?=
 =?us-ascii?Q?ertF641FmoQw3rUb2CAY925kefGA0oKjfL2ZDPB/9FS4qYJ2HbuNTP5pjKlF?=
 =?us-ascii?Q?oATPMWf5bkLFjqfvcmKaWy65Wla9j9e23gEbj+wCs9CnRisQR6Ir+D/DZUxW?=
 =?us-ascii?Q?ZKJlXj/8lpcs5Z5MJGL2Z9e8/hw/YPmgMu397EvvzB+hTQJibuSdQz97fD2r?=
 =?us-ascii?Q?e6vBZ+n7kj2jrMOsGNMfA03LTtkhBT+qwB6CggllMwC2x5Ku16KgaUgP4Q0h?=
 =?us-ascii?Q?26L/IoTFLNXgw8j/SjhmXcM/D4AvA4ZcAwra6oIDry4zyKnuFIjQNZcChQq0?=
 =?us-ascii?Q?nT7VbaqEwjoE/A98Vw9fuCrsucWBYgG+EfL2iDDDqWeEqMz0SInZXLSLGjF9?=
 =?us-ascii?Q?bJrGk8DJ/1AoEyP1L66cUXzXaMILTrOv3UTD6L9Lyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OrEUCvEy1ZfgYjfkjXiD2/csVxq5ztVs4PnkASYtmaKKhumA1TDd4vilILE4?=
 =?us-ascii?Q?ZioyoQXlnIByuEZDCOEoqW8t2MIPmRHFoBJsm0a7hnPE9X32JreA//IDZwvg?=
 =?us-ascii?Q?b8veugDUHkdLvwmyB10iUY/d16dET81KIfokX3Yuidm3l+aavecxMhPLtkMk?=
 =?us-ascii?Q?K9n/Ffrch+V6xJVE+5BR5AAoGvRt1DHek17nd+hmpCovLieh8uP27NvTnGx8?=
 =?us-ascii?Q?ftv+xUWMzPtE5JBx3YKMRNQbEOb6eVcVtm2t63CStn9PBOlhSXHIY9LmurAc?=
 =?us-ascii?Q?W4P64N0gI+s+1OJ4dPeazmu7f+Xe6jZKfg7NadkJ8pLpNoqgEpQ4vofW8k/u?=
 =?us-ascii?Q?5LHfx+FtogKPqBVBnfUPfQaregplh51I4pL3XpX49IjuYde7YRivu54/pbqT?=
 =?us-ascii?Q?tdfgmWhgk4RbrJkUp2vFqaEtf7jysHpl9RNxjB+2Rd8Uzn971cCjXQLEOrNu?=
 =?us-ascii?Q?FlFAcxsyxYQbh775/uhtUdo11gL5KLD5plrR1t1hDU15IXH2zzhDJL7t9TT+?=
 =?us-ascii?Q?9uH8afK+D0e+QHpFqTxNODqYl5oWqDwmHBxxN4op5Nvyr4wQpRlnA99sTErL?=
 =?us-ascii?Q?FX5LPtgyhOgTzQuaZsK/U+8On5kYI18BaIAwZe+9LI1MR96lBdd4MMCrpt1d?=
 =?us-ascii?Q?8XB01Qihgtm48lcgtq7NSusUfdvSclpVm2jt97gnxA7Oz8bZy3f6NxZZBtIi?=
 =?us-ascii?Q?iOloNsziSTxeqlfTDBORe35sjoawGsQwZg0Np7Xa6/ac/j0GAUYdZ/L/+fw9?=
 =?us-ascii?Q?2mOOctvVXUtwSDRqqasa/1JqekWnZp/8bwoGPkY8aSwJSl+Rsi9es+E+rdlK?=
 =?us-ascii?Q?XyyvbaYf5W+qvSH+nqv/4j6tSOUGAtJJMi1fzZrbj0pM4XqwoEj/TyjwapKl?=
 =?us-ascii?Q?4C7Td6zOYZ52moxCF+Zw3f1axDQFnbglaUJri7RbPxVyRGdwEZay0d3/eLdS?=
 =?us-ascii?Q?mMmbI7qlKBcPwA7pmraW4ZzYIJsg1zaXE9bQfJp8aTuoBYRCI+8rioPgR2Ok?=
 =?us-ascii?Q?tCCu7pZf+SexNrOKU8AazUxnLJJcVGqHE6JKFfX4MKSOGsSspVABce1DRN0M?=
 =?us-ascii?Q?leK2Qqk5YKs+xpWDYIWt+VdU8f+CDUGa1mEzOXWeMg0fDKtaLMoEc5rb1pcl?=
 =?us-ascii?Q?6ZITLdevlLDfrTpYGfBPR/KHHnZuuTjEIoQg533ZeEpTyNZ2e3GSA88cLU9i?=
 =?us-ascii?Q?7dzLVd4F6IkGX7GOZsC/PkA4TeVFiBxmff7fUMP0SItCvXrmZqCbvw10J9+M?=
 =?us-ascii?Q?o2GBNN7RCI6lCThp7y6XwmAL3m0JBRBzzlbuXnAbHHmeEbEKVCtOpFrnP1eD?=
 =?us-ascii?Q?TkDz3y3Yxsog39IX0UMCfIXQPUYJ6KvcxuYK54K3uMs7mP03xOtnyaHBAbu6?=
 =?us-ascii?Q?IXvPuEEg6YefQJNMTXc/Box86XUE2ACgxlThAqlkU/Cgj1sWSHmaEybbvEFa?=
 =?us-ascii?Q?ra1Ojc7VjzSlKygta3BWU17FrBeu9v90OKESRhB8/ncxh/UmkeFHzCi/N1wx?=
 =?us-ascii?Q?ksLXWiLtzQwSeq61Fb4qfIT+R9cAnykHl3JwQoIyLOiJb78QHWtqGkl2+4y9?=
 =?us-ascii?Q?72rhC9cTrKP2khcIET4j6EWyaFWxnldEDpthGgRWJSfNmoUiaAeJyKXn/K5N?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a8fa55-99e5-4e04-fcda-08dc660d1885
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 16:22:41.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQY0CxwnfaiVF1xw7xf7aLogzg0VVyPPxUIljQtOt+d0ZOEjO39ow+FmKVRlK8IDtnuaDNzejmqjvtuVwH4HlmGehLfotuq8uxU8KpcN2WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR17MB4087

On Fri, Apr 26, 2024 at 04:55:55PM +0100, Jonathan Cameron wrote:
> On Wed, 24 Apr 2024 10:33:33 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Markus Armbruster wrote:
> > > nifan.cxl@gmail.com writes:
> > >   
> > > > From: Fan Ni <fan.ni@samsung.com>
> > > >
> > > > Since fabric manager emulation is not supported yet, the change implements
> > > > the functions to add/release dynamic capacity extents as QMP interfaces.  
> > > 
> > > Will fabric manager emulation obsolete these commands?  
> > 
> > I don't think so.  In the development of the kernel, I see these being
> > valuable to do CI and regression testing without the complexity of an FM.
> 
> Fully agree - I also long term see these as the drivers for one
> possible virtualization stack for DCD devices (whether it turns
> out to be the way forwards for that is going to take a while to
> resolve!)
> 
> It doesn't make much sense to add a fabric manager into that flow
> or to expose an appropriate (maybe MCTP) interface from QEMU just
> to poke the emulated device.
> 
> Jonathan
> 

fwiw it's useful in modeling the Orchestrator/Fabric Manager interaction,
since you can basically build a little emulated MHD FM-LD on top of this.

You basically just put a tiny software layer in front that converts what
would be MCTP or whatever commands into QMP commands forwarded to the
appropriate socket.

When a real device comes around, you just point it at the real thing
instead of that small software layer.

But for the actual fabric manager, less useful. (Also, if you're
confused, it's because fabric manager is such an overloaded term
*laughcry*)

~Gregory
