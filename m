Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033EF23314B
	for <linux-cxl@vger.kernel.org>; Mon,  9 Dec 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751059; cv=fail; b=pHHEXnJyfh/8WhQyDvO6prinvsIg9BsINWlUs0Z3X5qJs93l6sAhljmk68LGStYZwLJA+m/81r1g1lz1I38K/iGIDUOtPTCYTwNf4vi3qNY4HnYGromrx1sLWRtVVAYy60XUALJ+h+uO+k2A3h69J3cioUDk4ArVusqFsfEWB+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751059; c=relaxed/simple;
	bh=h/Les0H4lz9hm4ZBj1mMGC7h7ySjehp+TVcF2R8mjgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ijpyirwHwhpunyAD4fMPRKSJij47m2diBGpE2fOYcao6fIJPwFP1HfSN3HU/d1t6jnlEKq0wD8fI8powD1I9mZMyobmM5OWHhhN+OVVRq5Q+pRtSZB7K7Lxoja5g24ZMeGFXCKcYC//HsM8gNcLHDzthxeT6YajJqWimoRgiJi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uem88msT; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uem88msT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRJz3lCxR6CpnfUFLkinIt8ml363trOgMwYkMp4X16xxdwNUvR/d0kruYeXg3CrQ7KGhBzp8VBF8L66LOCyXSE2DPaCEgBISEip9V606sRBdo+2j5umRpSuCGzgygc321UsSpEg8hlrQG8HK0cllgI9+tndX/ipgvpfUw2yC3kFC9OeHXJaadWHLYUZZHPYTjKXAlCCUsbpkh/zjNo5QRwnBuoyvAjgPsm+FVVaczmxSYymyXTpMoJ2LHTu4wxn8nEzKtK78Pc3ByaKdueGai4HRZpWmiud4V0u2ypJGkz72JYLg3lfeVzMMydNHboOG9+urL/CQ+U6RIt4Qk/2lgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5ZYdD87GXpTWHFVCE7AJit8AwUFhAVCIifYbJ5ecXI=;
 b=R/AzO1Ov7brEZAWZ+9sD1GhuBecp1FJkbxL+8757fzgUKgZEV91CH/A8WTxlflFFmZZ/RLNSBrxc1d0wgG3GTJPtyQCkh6yseST/8Jxse9QxQ15MQ8K2to0Y/enZQq2H8HhZbviZPgUDCCj1stbUfi4aLPmwkXCdXdopIikEYc5sWhesr9cPuiI9S9X5hxRZ7rhBTU+E9QAsCKPPz/oqJ+JnMnYO7DyF9+7S1XoTjih1Vpw5MqUMmrK6sghHTQS7DN2TFSvMyMylWOt7x4nh5nx755uoNsPIdHGYdchs42mV5AHWmORzzCXPtycEl2Sdq3gDY3iReLgtf27cq6Ofyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5ZYdD87GXpTWHFVCE7AJit8AwUFhAVCIifYbJ5ecXI=;
 b=uem88msTmeOJkeiWVbbgXSeF93ClJ6hQ31ZgLqgYuHmMkXoidsf64/vhD6Jg2FAtAlzcS3SOsPNjQ10wTkJeFKDpf2k0FTsUnfVssHw1XhHPmeH+IFIuRoS+wulu64Ztrs0oEN0/YH3SyR2aRMkMikgsvgDdHt2MBJczXGUh+dTIi9DBIgFHzQg/s06iClmK+vUM+MSgguDXbQOnakfUcdSikJCmAcVyk1/lNoRMfh6BVEEad1F8ZELILa4VTIdeaX7v27jOeoKF/eR5HM4AHXQUQUAeA6SvTuK7vQmAuqkfZRoSBs2VAuAiGEsWSll9111TIGSzz3bI1859Pr+2vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 13:30:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 13:30:54 +0000
Date: Mon, 9 Dec 2024 09:30:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH v2 09/20] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
Message-ID: <20241209133053.GA2347147@nvidia.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-10-dave.jiang@intel.com>
 <675251891af76_250732949@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675251891af76_250732949@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BN0PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:408:142::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d9d2a8-042d-4d7a-244b-08dd1855b4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dJHGc8JkkTXnHHCvUFZzPaRDS2QbWCwsrV3s17UB4cHD7GjJ1AK3zk7Gblig?=
 =?us-ascii?Q?uxKs+Rl7is1fDxlenSRrQj2Odt3KiGPCXsHboaGtoPJz6VzGtOniBhkZfN1D?=
 =?us-ascii?Q?65Etv/Vy60xswaB96iqAzp3fWs32rQd2bLk3tfsJEz3TKTNaxkXu7k5gLxT+?=
 =?us-ascii?Q?7ChP5ZngZ22DBs6N6TuFR0XgBeSPg/vxgJE2K15njGtmmj1IEOlToAdz7dE8?=
 =?us-ascii?Q?iX73wEza0Lu+/p1z9LDKadOHd0LhUSSM5nGEcRbqJmvkWB4Wpa1wI/Fb1GPg?=
 =?us-ascii?Q?DCavygv1kc3+UeMO7KPgMnwh3nFuyipdy189BSGZn9mCbLbsJhC3CtEB0XXb?=
 =?us-ascii?Q?LDyHZANmPo5Ln3lycdCYvFb0JwU/EyJQZfB7eE+U089yCZJ/W2tXFJSfi4u/?=
 =?us-ascii?Q?ETaigRZ+biIS7zlCLP65ej+6QnZ4y4g5zkU3PVaLZdVb+ee+5K7hy4tK6RqB?=
 =?us-ascii?Q?qohzOKuT+yI8M4lq8ageLjxkW2JZZG9yugc7Ij/wtfY5D1mASuv7iKgGdnEA?=
 =?us-ascii?Q?PkE8dIAwwmrprWbWuInrNiA1qiYYKL8d+y2y/bsqorFUAWdeSEAy7MxISBGo?=
 =?us-ascii?Q?oR9dAK273+VD+1NEJeDszi5QUA9+dQPhOmgMsC+Bb4ggO8HXp6UqrUEr5Ax3?=
 =?us-ascii?Q?6D2Eup3J7aSczOlI2HAsCnwIEYfKIACQqGSHDCdB0f3uAh3x+T/J+5PkZl5O?=
 =?us-ascii?Q?9fjNNAJqF+zCGdErLMi4FJ47WJG4P0dcqMc5AdG5UI+mUw8lzOckTYlcBMnz?=
 =?us-ascii?Q?aMm7lqZdeyyeq0nRza/W8/JhNgh636IgVNxOR/raHdE8n47tM4NxH633CiWa?=
 =?us-ascii?Q?wxHjdg+nX2sYT+GKZFUohLFNNgXvratMOcAjVHDXUPL2ZQA8zutCSZeMzRwC?=
 =?us-ascii?Q?YfJs/aXTYuqF57NrLng8Tw6v5uIurLQTna+ZOkHsC0tTcQqjr6Zh21dfg5Wn?=
 =?us-ascii?Q?5LpqiLIy/RxGtACgiGNW4kydEZ7p89MDlxGKT24WIe2X+5jZy/4UASQtApT0?=
 =?us-ascii?Q?YqEkvSNspHQ1xFIt/OKfjRXfZnga0sGVSEMmgm+36zVzrz6fYZ97Rg+a7uJK?=
 =?us-ascii?Q?BSsAzetZwmM1a5Zx5pIIxI4tUwuN4t4NVMTC4TQ+osT+y399htSktq/XiJ3s?=
 =?us-ascii?Q?nrVBWOlAphte/j++twUnCnMw9OOLpHv8CDUxG92RS1MFyWhUBdBAYF0q0FkI?=
 =?us-ascii?Q?N94INFVXUiCIc4T2mIiDuic8jGbffOdkJ5Wi5TWwi2ygTU9AajfnNhiTJtOn?=
 =?us-ascii?Q?8BYEGUzVC/njjlvLKLJ5KuAve8cDGOhDbTa2OxuOrCHCgvCfeslW76LwMixh?=
 =?us-ascii?Q?BPYSD6lY6guzy3l6c1W/INsfEq+c8ehtDIl4uwTqWPkYBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C407rR+NsBPYmUU0eqFY6Ypy9/a1PN0SIq2HtvVhStyQ9JiSDqwVP7lxnDtL?=
 =?us-ascii?Q?MatB47urI8VsAouOrgtDoHemMkeRIkOaUdFXdY/Tt8BlKcJc6Xe6dQ2SgYxB?=
 =?us-ascii?Q?lSEYMcfx4Pkh18lRgCFZpstvCFaFPv5wKPhyuMyMK8UiqjVupTp70ezfRBRh?=
 =?us-ascii?Q?kMXvucTYDtqkCgmPb+Ei28mbw47liqihGwxS3iy095K1xhuBvQ8ckY/qd8Ua?=
 =?us-ascii?Q?RdTqo1jwoprqFqIyzCMLoyU0D2P+z7jmre8PmpHHMgLs3uGYsFS7Icy5BHWT?=
 =?us-ascii?Q?rvVPCg1XTPof0gOoAA87iMpCPlzDSp94zpum3D1ynI7b/6orQW0wt5CeGr0z?=
 =?us-ascii?Q?vkeX9HmePxnJHLbQa77NXTauKFSIcb160FtPmd+j/nh/PDNd6WUNqmzueDir?=
 =?us-ascii?Q?0dSTyqbOL2CoHoFLi3yXkN22cy6aA0/ZrkSLp0Omc7bwpYueakAwCBipRLJc?=
 =?us-ascii?Q?xc0cLX4EQhoPGggjsiveWMj6pdupMUpL6B/sQaOTyWsuriDwO1jjyL9+xZTR?=
 =?us-ascii?Q?Mt8mVAM9p1hEAzgwP3rZIYDa57hCbALo8DZ11+q55OUhZgi8MQPx9maFHOTH?=
 =?us-ascii?Q?juwmLWVLrIwF+4n1V4GVfaxnAq0CSv5T57nUoHQuiy5m2x1fqDmmccME6lVG?=
 =?us-ascii?Q?ksUxaraihif/ihXyhJjhOF3waJuZrRY+YcyzDfBZzyYRc9OnMg+HiHRCnTfp?=
 =?us-ascii?Q?L+dLah+xS4QDsSkm3DGQZboTiGLIhIP/QtGMBQ2BfVaFsQnUlokfeOvaQXjx?=
 =?us-ascii?Q?SMDtdoLYsoCP8aRe6ERC9gJkiGJtlxk/sMfkDvbtzH/d5zeQpXMoZVUzB/Iu?=
 =?us-ascii?Q?EQwwZ1G8GC7UQTzEop6lyr26T6v2IN82EXZVrQTIZgIKvNtbtFOi7YWTsAZy?=
 =?us-ascii?Q?AXXOisIu/lS2G3evXk0FZbKqOeJJXhtmoeQF3Gk3a7CuCP0Z9x7gGINRO4qR?=
 =?us-ascii?Q?uoBTkaiJJC0JoQ8ubgfavzJq3p3GxZ77zYgGOIyFaEzDa5MGSNJeIvwdXLGx?=
 =?us-ascii?Q?kDsCkxN+rrfAwIvdVLgF/hxjyEFEqaEk8qbjbtQmn6FGCoHCR6VlB6fz9JY+?=
 =?us-ascii?Q?MhxIZec1yJkSsINvBTfGVdVYWxBviQ1aYu3tMlG7OKMLhzifodTh6qJOy4jR?=
 =?us-ascii?Q?YregjXRPYlyskkMBNPSEXbKsNhvxxU1xUl3OyVc3GImBun9/AksrH0+5IAU5?=
 =?us-ascii?Q?7fs4wL1byVg+ks5bOliFNKmPAahSbcU/wEf7CbaBQCE61mlBgLfsylNJ2Fvr?=
 =?us-ascii?Q?RFYg5UkYi/6Ak3ewjZ2tu23dvNSw+OxLATU8Zn0kdx9PMi4UIHqaDQWU6z1Y?=
 =?us-ascii?Q?HOmvzsLNXzTBg/8NqlsPFStA3YGEI93YJAnCft+hKB8ngOdvkw15OjKsI0oF?=
 =?us-ascii?Q?dzSVrMiexCynLNRFpoTJl3wIU6TcE1E2terXuMWw0nE8txi37M3Dh5SlKYH8?=
 =?us-ascii?Q?Ze0C5KuOvUjLV4P0GeuRx7REgsO8OotxOexuA2wwpYaQRoRZpXM+MAdxyj4f?=
 =?us-ascii?Q?f4SODN6uMgG5NSJLWho5wCyHjbXwS3WvK2ceq6diwF4wZBFKF6XxjLYMAKyY?=
 =?us-ascii?Q?sRZvb3fQE1ZZTItPJ+A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d9d2a8-042d-4d7a-244b-08dd1855b4ec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 13:30:54.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEeDCFJJ01Gn2PNNN8AhXX/Eb7IPP+2fzeGKsteo9Rk1Q9qADT52rK50fVv1Qe2R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419

On Thu, Dec 05, 2024 at 05:21:13PM -0800, Dan Williams wrote:
> Dave Jiang wrote:
> > Add a cxl fwctl driver to allow sending of CXL feature
> > commands from userspace through as ioctls. Create a driver skeleton for
> > initial setup.
> 
> I don't understand why fwctl support of the *existing* mailbox needs
> yet another sub-device and driver?

It is how to modprobe the fwctl driver independently from the main cxl
codebase.

You want the fwctl parts to be in their own loadable module even if
cxl core is built in, and the loadable module should auto load when
cxl is present in the system.

Spawning a new struct device is the best way to do this.

> In the mlx5 case, as I understand it, multiple families of device can
> register the common mlx5_fwctl auxiliary device to share a common driver
> for that piece. For CXL that shared object is the 'struct cxl_mailbox'.

There is only one mlx5_core driver. The use of auxiliary bus in mlx5
is purely to split the driver up into many modules in many
subsystems. Each subsystem probes its own driver that autoloads if the
underlying HW supports that subsystem.

Basically, it creates modularity within the kernel for complex
multi-subsystem devices.

> Now, I am not opposed to drivers/fwctl/cxl.c as a library that the CXL
> core can use to implement CXL fwctl support, if it helps to keep all
> fwctl users co-located, but I don't see a need to make it a new CXL
> sub-device.

I was expecting that subsystem drivers would reside in the subsystem
directory, so it shouldn't be a library, it should be the fwctl
particular parts here.

> @@ -5772,6 +5772,7 @@ L:        linux-cxl@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/driver-api/cxl
>  F:     drivers/cxl/
> +F:     drivers/fwctl/cxl*
>  F:     include/cxl/
>  F:     include/uapi/linux/cxl_mem.h
> 
> ...and call it a day.

Makes sense

Jason
