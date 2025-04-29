Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AD42FB2;
	Tue, 29 Apr 2025 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745890672; cv=fail; b=unDydbCLrWIT5DOB8DKjXtzyFoZq6als6y8WIFaNjY7QW+e7YFkERmHLe1hFJmyIfP/5o7iAHj6X//6b1WxNYkWMnZopTSmMsETHrcD1wXgVOWQ41lzwhXY0EqWjnnUuYWsB9mCEAJqshJZlIOJQD65/0cPybPg7ucZ/qRB+LbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745890672; c=relaxed/simple;
	bh=OzpAlqkBZ35RMI3ky3qfMXtDG/eO9QtkAHq++3Or6+Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L25Fa+Rzjmp2kqYUanRbK3G388gjXsW7ukWNfNt4lYQa1URVlENfk4LO/AhxBUD49Tmpp1zSLU3aqTp4/9RixZz/3tYxxwj7fSte7lr1PItNHbtWye6UvnQFGEet+uwyyRmBF0LUreR6OwJoCui8sMoSZFr4L+gSjk/dnLfbjtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsAvRD6w; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsAvRD6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745890670; x=1777426670;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OzpAlqkBZ35RMI3ky3qfMXtDG/eO9QtkAHq++3Or6+Y=;
  b=VsAvRD6wg183mDERSQ4Mk6TYrkGXu7Onr2yUad3+vqzx5+iiihrHx+hr
   JrJGoJfya/405LOENppnyL7S1nLLzZk0SlQLQfJp3N2hPDdZA1ZnI7xjK
   SwO6jPS9yR4wZC7LkBoxw0DcFEX7QYGydlFXoYSTViytaGqUPZ75SjRdz
   jw3jYhhOcmIkzAQVZwhYwu74QKfAWn6IbcaPJBCBGbwl70ArT+Q/40+7i
   z5Jd4OPdxc73ddI5rmfvPAMo9dVP8j/jxSQKeQwTJ0863FbfW4/qErvQ/
   opIyERoeOkwab9+gGpe8yHfZFq0qb0KbNpN4L4n/MFDl7PLGJn+A+SI7W
   A==;
X-CSE-ConnectionGUID: JiXBocLqTHS6qX9qBun9Ng==
X-CSE-MsgGUID: 90h5JUFgTHuBVVUB9qC5PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47409159"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="47409159"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 18:37:46 -0700
X-CSE-ConnectionGUID: BzjE0oYQR62848ji/7+nug==
X-CSE-MsgGUID: qP/Q21tQSUiqgN3PA0OIxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="134655657"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 18:37:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 18:37:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 18:37:18 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 18:35:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzZLfYKKE3AGw2+ZSfWxG28Jn8L/RKgJ3jFjJj1UPrgQYt8+GfM9r/JT/0mtTgTlNbMw9ICC1P/xz8mX3QuXwAsmNrICIRWZCMTgZ+eh6WWxHEyI945sayBCAv00/0aORKvWltyvYFekPOS7A1L2plenrzEnNViD+AjAwSAlcfyB75ZuYdq70fcLde6n49XFH2FxNcyP3BD9Eb8KEQE/4OXDIzxEmHidqA/URXSJ98LesF4Ze/+RmbnXkQk7oC03TSWxXZ2fc7J13nJiKrUk5PjOAkNBrf7WbhoQUx2kBWrg8jxLThKED8S0IACEIY/GrwncLDt/9tTMCp9VyJUCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7KTnYhxGMM3As7K6PFeLtm3fPKDwTr+gFPiL6FmlDk=;
 b=FXnpR864OMlCOHpOF+78tQDuzIXRMUOwv6WqkXZr21r/NIHLY3k2fb4nlQxlhrnZSUlXVZaXkQ9RAMDKw2yNZHo/rVPc9V56BshW+VKiIZLs6+AzXIsQB0oHnG7XtU3nAT2JvYH+aB/0B7wTuz94acMznWLg+85ZK/L5LSZtHFekVLPOcRHYl81HZ+zcUnUEqzqxS1HAgW2iqmAuPPysUU46vtidtHK1/zPcJwu+pqrxaL/o1TpSlbri7Z/Vg65Kc5jA5Xe2vNuz22iTrUq0AnqBOSU+N8ON13j+sesdnV6gBkeoczfw253bVml0Aas4UXuuD1cCVom4a1HhSSKtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 29 Apr
 2025 01:35:49 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 01:35:49 +0000
Date: Mon, 28 Apr 2025 18:35:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v5 01/14] cxl: Remove else after return
Message-ID: <aBAs7LFYajgrMKTl@aschofie-mobl2.lan>
References: <20250428214318.1682212-1-rrichter@amd.com>
 <20250428214318.1682212-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250428214318.1682212-2-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:303:dd::7) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|MW5PR11MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 9216002b-2428-4b85-b44f-08dd86be2bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ihn55cjTcV72jObK98TBhpb9ZirQSkJOQwjuqnt48bBi0ptd4Ubs0b6ldpe?=
 =?us-ascii?Q?x3ANtQAxA3hvwR4NH2RBOAL4j3Tooz+YuP4xSVD1pRbD4yR9gQBVDQgVNM9+?=
 =?us-ascii?Q?uZsXP8/juTU13jiRedN9fwo75vygH5mdUnpXk22f9oVTtnHOjj3itmVnoxsC?=
 =?us-ascii?Q?am6vbA4zs6KhuyeOFmQYsFEPzfpe0iwpxaVg7IMrQk3cXMNIf5PjWnTXFWQz?=
 =?us-ascii?Q?wQBuyr4LwCjaaJO7qlL5FKQdEb2lqq1f29R20sjU5d1q5tJQ9RWOzhNbhE3O?=
 =?us-ascii?Q?xPhMu4MXqxygEFFHn88EOJwwmk/SLHxFBcvhC9JFfQ/S3eDtHd8lS0lmfMiN?=
 =?us-ascii?Q?leo86uCw91UOe629fDftT11/mVOMXHLyeo9UmCVdQ5YcP5Rl4x9xJwI4VCpm?=
 =?us-ascii?Q?IWUqJJsuNrSD9HSPXuFc+m/0TBr3xk8tnV3bGwTS96zz+VI3x+elCEfO5BmF?=
 =?us-ascii?Q?ODrsVN/Fu434FwuXjkr+DXFGzBwR1i/EPhMD44XRpzoWsfaIg5MnNE5mOxOB?=
 =?us-ascii?Q?CGjGALpJ2o/2PQw6Q4qMx3Nh3frULzxgbAYn9cBjUxzyDnvNQvuWSgr/wQHH?=
 =?us-ascii?Q?G7pGbEsUewIMS/TlFSKof/ZNT0KsrtOAIfUlSDkoZkO9L8usTy9z60fMoHN6?=
 =?us-ascii?Q?xVXDkNQI2OSst+fkZlVvPeNrS/GqhuRutbrNoS1UGrSktcxLJ8ruYGzhho5B?=
 =?us-ascii?Q?dHZYQKj0wxoGcp0KwhuVPK7PvSpe36qYyw4o4GCxYB6H+jbpKIAEvfkSa5g3?=
 =?us-ascii?Q?9Kv7cDbI9/mqYHrzwXE4Ps9lNfoFru4XPH1GIzuvhB16tttWFyF7uHAcpLTP?=
 =?us-ascii?Q?eXR41AedxxqN8a2fD609hFQU9xV3lnwkqVs7MwxVKCWfqLIRQqiy5w8JjslS?=
 =?us-ascii?Q?m+1VCkJfEudxHXY/+DHRB/iNKdoyvxj2ironGaFXpuF8n6hB5g5drJGXwpEy?=
 =?us-ascii?Q?Ru65OfkKv6AnTSyohtfEssWHD4su/KlHt4Q4lUk7nmsXkhOCxCqsvDZM6X+X?=
 =?us-ascii?Q?4urqFg51qAO/oLIgj0SRiTZhfuPGQqOTcvoOghBsk+yZ+LobIY51av4HjoUV?=
 =?us-ascii?Q?1MCXIDl1DiEawKTdMYERtz27fkllNsKpoTBqHOVcrYMw8ZjKmfDi3Vrae0P1?=
 =?us-ascii?Q?F6ENqiMYoxgFfRYSr/1OdPVvKJOwMaqmfgf7iwQDF+NtayUDhUgwobERbq3N?=
 =?us-ascii?Q?EDQVYmknf/grbViYvT5D9zlbIJGr9g3+MQwZ7y8FGDFQR7KZ3XKYDhn2Fdf+?=
 =?us-ascii?Q?QlV28CoT7M5tHZQwLHw7FG/DunzhS8w03H9+7CH1YoI0jXj/humnkaMmyoiA?=
 =?us-ascii?Q?o4LQOwPTa/imdJuIvR4S+t7jNVzaRVx5iE0eVXsT1qScKSPIkKCMoqkXYk+f?=
 =?us-ascii?Q?sMoDkm8TPg6NmWrBfLrJRku7afZ8cwWjlCJ5YZvu5ScoC8yb/ikizd2RmbbU?=
 =?us-ascii?Q?w2VvDG8zsa8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xB4I0SIdpPmU+Evus/8EqRLS0zHnkazhR10VOuOYO39ArO0ntU/NsDKtz1Tw?=
 =?us-ascii?Q?FXywvqs7SqnW1618+tuT6rOBo6NIALPKCci8Bsdshr+Et0E/5yGJf+q1v3sB?=
 =?us-ascii?Q?KJyy6sbSL8auG9y/S+Crn5vUgNFRWczGzG/Zzo7ktY9EIpTs0Vqy40q3B0Hy?=
 =?us-ascii?Q?Yzr8g4dRYo90tglH7u2A0Mot9K6xBTeOAETFICtxn8BJC+RYm0xr6U0+RBfI?=
 =?us-ascii?Q?dBjoyHbSYESFpAsRyNjD3IbwsILry+4OJodX9Sc9ymAZEH6sbiXgiRNvl1UI?=
 =?us-ascii?Q?Iy1g5DrAvB1l0TMQgi6v2aiX31FYbl2CK6rFduzJi/WoOG22InmSFzv87I/T?=
 =?us-ascii?Q?7V4+sVc3/B12eqdhh6GihMRoES8fvJPGo8j7E9uOZHCj0hSEsoPjbIYs/kqa?=
 =?us-ascii?Q?v5A7xo8M4nVJK+XWp9WJLsOQXpQTEAV7aQjQYBfAx9SNskKJpkmKQTHYYyXe?=
 =?us-ascii?Q?c7GmlGRx+NeARPY8PjG/20Ic0QtI0L8mATiO2nvJsOgDOcDu8OghthCH1F0t?=
 =?us-ascii?Q?NK0mgE2zVH1OFbIPRkRIXqmauwz8SYQVUKheYtY9s0uS8IdVNTXkKMXOk8AA?=
 =?us-ascii?Q?GIGeegdObTiuuT457dncGp69fyR7w34SPCW/73iBo1nT0sBEU8B3Jdq+JGch?=
 =?us-ascii?Q?6NEcoEZQ+LT8jxm+fo6fvLemW/uSk9+2dfen1ZQS/T+mCMj9JTw1tgqJnWsm?=
 =?us-ascii?Q?5zlMnSK2793A3fagN2U80Z/Nf8cCqM/vmk1WDVrWBosS9xbnhQN84lw3rx8k?=
 =?us-ascii?Q?jqrbJpbP4d09wqd0qy2h1pUUTpGOi97jfSZ6mNFGjxL3YkfS0trfU5PHdoLV?=
 =?us-ascii?Q?w0SNYUXovUS+dBcO7xxsxhrt3U4AxkVAGtYTs1b/KkfDMsSLyOc7u3kmpz+t?=
 =?us-ascii?Q?ImgWqSpqF/VhNVae/b81myqmbehH+7a/EAtgk7oXdx+asJi0XVYlQ+VUtSQn?=
 =?us-ascii?Q?Ol8fLizE4knflV5/N2773dQFyAJLYSLL1sKQKMaQs5S96McTqqxx/vJp/8QD?=
 =?us-ascii?Q?soOscC4eF6kSy+Rks8shoh02WSjj98tXZ02HJWDrxh3RFQppT6SIOq2fX08Y?=
 =?us-ascii?Q?owk4RwVQilsgXdrEAQ0FmSRtt5S1FffOm9mw6X3TSy/xp0Xxpom793tG8WCM?=
 =?us-ascii?Q?58QWbJLFs4FA0kfXT2gOjxHn9KZsRGRe3zzAtI47iFRM9Iqbity/9uf8zbVT?=
 =?us-ascii?Q?8xRdrW1qRb1YmhG7pWKfKicE3p91CQuklINaDiibSzMx371Qh9dGvF9Hrs8+?=
 =?us-ascii?Q?W9msZMGbtr3NHXphGvskZKUN7ZvtW1BUuXhYLYmlr7A0/9i+eYaKiH1WF4pv?=
 =?us-ascii?Q?X847E6rhuPxWpaA0EZ+rIRJFXStmzNHmgz1BmxL+1LadixwV5GjjC/K0WgY0?=
 =?us-ascii?Q?kwbN+1FymgTG2XqxwmiKHqUjWDyTufXBK5RrUtC3o2i4SQ7Lh/+ze9WXKEA7?=
 =?us-ascii?Q?pzDwGwnOVYJV1UPqDjOwdbiLJ3puUR4H45JVOeA03h8sYZ0VLU4XP5eqJfql?=
 =?us-ascii?Q?/BbPmH5kAfTTy4d8Fw42prGxPqs9zfQYCBdI96X55BGRxvwA54XDfXgu7T3R?=
 =?us-ascii?Q?rG+03s9NS7XsNdF4wg6/rcSWdjVTW6hJB8RVknnx9eCABMYQHtCmXwlTQiFw?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9216002b-2428-4b85-b44f-08dd86be2bbb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 01:35:49.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKPSIgVL8Gbz29avkv38iz5oVG/N0hb5yB/eqHrU08mijJF6i4G2zISILdfvO6vdSimqyz6/TGSM8zWvdh3ZKMv8QI6BpASm5lb//KvWeQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com

On Mon, Apr 28, 2025 at 11:43:04PM +0200, Robert Richter wrote:
> Remove unnecessary 'else' after return. Improves readability of code.
> It is easier to place comments. Check and fix all occurrences under
> drivers/cxl/.
> 

Seeing a gap here. This claims to check and fix all occurences yet it
omits the one instance that actually triggers a static checker in
cxl_region_invalidate_memregion()
WARNING: else is not generally useful after a break or return



> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/cdat.c   | 2 +-
>  drivers/cxl/core/pci.c    | 3 ++-
>  drivers/cxl/core/region.c | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index edb4f41eeacc..0ccef2f2a26a 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -28,7 +28,7 @@ static u32 cdat_normalize(u16 entry, u64 base, u8 type)
>  	 */
>  	if (entry == 0xffff || !entry)
>  		return 0;
> -	else if (base > (UINT_MAX / (entry)))
> +	if (base > (UINT_MAX / (entry)))
>  		return 0;
>  
>  	/*
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 96fecb799cbc..33c3bdd35b24 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -415,7 +415,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	 */
>  	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
> -	else if (!hdm)
> +
> +	if (!hdm)
>  		return -ENODEV;
>  
>  	root = to_cxl_port(port->dev.parent);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 80caaf14d08a..6bbe04a532e2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1940,7 +1940,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_dbg(&cxlr->dev, "region already active\n");
>  		return -EBUSY;
> -	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +	}
> +
> +	if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_dbg(&cxlr->dev, "interleave config missing\n");
>  		return -ENXIO;
>  	}
> -- 
> 2.39.5
> 
