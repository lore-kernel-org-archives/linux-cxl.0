Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813591E25F9;
	Wed, 14 Jan 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412333; cv=fail; b=S4T0gHSMWQsyctQZPbw5abJanPJxgPri7jy+8/hndNxJuz5m+w0jB2smLMDEKcvCkTuJjPIlYdtSF5CQ1UuX2+GXj4oghaxL+sQcTxYh5DjHzG0AevqlBEhex06RTcTu/43C4w/bGbUHecXH7slVqjaAXifD4BnZnTqCoUvEasE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412333; c=relaxed/simple;
	bh=bFGo7I58UNYXL+IHPCi+6EwD2Bb37czYbquEAwLxZLE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ULIdSsSFW+ov2jaGkBZQTXdwmoHx0DkKDcaHx5LW0WwEaAuzIkFColuwM/0I5hpwiW6L7Bih3yi92Tg1DKCdwHV9EM5LS07VI15pqY21/vtTwx8GeB0g7xhcEL5y95GT/NjkoX00JY42sQlkpxoBmqEp7u6zcDK0hWbczfaX6DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTlpwvzT; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTlpwvzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768412331; x=1799948331;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bFGo7I58UNYXL+IHPCi+6EwD2Bb37czYbquEAwLxZLE=;
  b=nTlpwvzT6EfTbALPtJXQQFFyy7tfstURSk9A4BGHgEVGw2op6gjoZLE7
   zjS/nDajiWbQrfg4TD3OZM6jaoHVZIj43DO00k0ynJ30jKNOsB0xaX5N0
   98inEmgtsKpa8+bRQQ0FMkVm225GMkArpqmI2SsT5DUr9lVFlT6WGDW1L
   3nCsq5UNviSY9ZX0k6EiRqT2q/HF1F9/tIx/IiuHtaiVyD3r+GA51GBXs
   YMr84U2jzqiKDHabNjlbtTbrr7tRioyfNcC0Q3F/RAVZpgKq+QrYix7WV
   /wmCR3JSdT+i5gnMsZMS6jgwtAhULtHJmq4cdTHTMG6VKdIVWJ7YIomsl
   w==;
X-CSE-ConnectionGUID: rBFgF4mnRZ+Y38rPJweEaA==
X-CSE-MsgGUID: NviP2nPjSmSSpJoOu6yRNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80016065"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="80016065"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 09:38:51 -0800
X-CSE-ConnectionGUID: HE5gKMtzTu+MyC7xhhtu+Q==
X-CSE-MsgGUID: qCDWlw7EQLC8ww7OjHv7Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="205006372"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 09:38:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 09:38:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 09:38:50 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 09:38:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiUQEgrEF3IlMuds0BAGCMTjw05EMSJFSpg14PIZnNUVaWLvSv7aLeh1B5Uk7X73srXeKijPDq4Utz40atAec0pg1vkBhFpkB49E8ARsb7fSvNHv3Pxwm3bohcNxVybbv+4FB6mYpI3X1XhOUe8t44t3ECJ8aOZy5vK4a4mc03LuH9X7LrwHd17YwyC6z3w7frx9Jd1Mdh5oHJ5G8OQ5uMyFZ3/PkcBUT5CZiU/U0VFhQrWiK9OrXj5yorgMsNf9jWGGpprAPbVWdO6FXFSbyRmvsXRScq0hwID0PENbw/tfIhSgd2kZLLTkCN9Jjk/LNzn/l4pY9ddiDMu/p4ohCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYtu4huxk+CyQxKlDS9AE1qvF24AIcBH1Gj7Vhnn9lI=;
 b=Sd0oarb4IxlUj7fjRKcewC1F7rtbFFXrGbgzJq8Gch0n/C6HTVTc42eiBn5XHWiUAUGcjoEQr456QJqup1YxJ3XJ9wXFOfqmWN1SVQoCRqVlgG58FhYEwZzDR86+E6t/AaxylQobDNhc5yLVSiGOYkNf3ms1imZCx5064wBlpCG4T0/bCAg5VGDQ0RawG3KhdCNyCXf4itrrn7QJSmnP2n8KjSxrT1F3hJbs0RJ2kHaMlzbxwA3rBd/2Vv1wPeYtwqeM8S68NUuEaWXlu9bxDfdOxO8EM+F8nTtB4zOWGL7ntf0VF9UDVFPJ6np5TrdhB4Ukw8wgtcHnLBIggy5vpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB5802.namprd11.prod.outlook.com (2603:10b6:806:235::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 17:38:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 17:38:41 +0000
Date: Wed, 14 Jan 2026 09:38:37 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] cxl, doc: Remove isonum.txt inclusion
Message-ID: <aWfUnRy5ryojJFGL@aschofie-mobl2.lan>
References: <20260112111707.794526-1-rrichter@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112111707.794526-1-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db221bf-0a27-4dc7-cac8-08de5393c1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?RLrJlkqb6llPXFlXR1Jre2gI7huLfiFOrGWF6h8gI3eiTvQP0JypQfxNDv?=
 =?iso-8859-1?Q?IOCztI/4QTanA5cEnwMSTDtoahHD21GwBuPgI8y048v8An+dYbS7SRdtR4?=
 =?iso-8859-1?Q?0vV/7qz86Sz5tO3ZR8nbYTaykod/J+OZ8HbnU098ouupUjSvLPpyoRxoVH?=
 =?iso-8859-1?Q?jKBws5cEWwY0r2qalldEz8Cm0iEK283t9ogS60EIXBzcv5fZEj7DAcqixT?=
 =?iso-8859-1?Q?YPWwgsHAjjNTTHFL8qDq/ZBoXJDBtPPcv0xJdHmerO/wQZjOAtsvu7T+SF?=
 =?iso-8859-1?Q?71YLBr3i+CSwKSPfxiWBUEPoqpQDYov4Zq0k3k3Mdh09a8YAAcwYpgrRP6?=
 =?iso-8859-1?Q?OWRIGA1KPBgNZqj8K63JVgC8L5SlEQmgGe/VS7vAePFkN2pERRLv0ks/ut?=
 =?iso-8859-1?Q?IVgKQn1gtIJ9XHolek/jNQ52+zUJOJQLcKcmFNpYJsD4NVH4op0w63M4ew?=
 =?iso-8859-1?Q?qIfODtTkX3N1IUeAdoZ5NEAZ0BUcRAK7Fk6lIKcGuJ/yfAFs2IgMdtkmZ2?=
 =?iso-8859-1?Q?ho0M/+g40cd1XdQzM45WV51y7/AYu3UQHUrvHTovRlJPwlI2UqYo+2WoZu?=
 =?iso-8859-1?Q?ocEi9QEDqmff8nSo3v3idAA+3pAMf8wIGFN1DQ7Da2rR2RzUhrBswmkJKs?=
 =?iso-8859-1?Q?MN/ESFaT+mLMRkO8droBD+DsoB4E5cr7cxnjr0X3OXy4xV3rcNV3w4dggL?=
 =?iso-8859-1?Q?V25hlUM8e2ec10sT+Z53VU+2XSFWn8hFXK3DF9qNTu8rVGMGu42nrT/Yig?=
 =?iso-8859-1?Q?/eMAJaea+VjpyEwxriGXZW5r5Y/Yh4vP8fCNURVIyo+mI/JO3XeG/bjutA?=
 =?iso-8859-1?Q?RIJIFqkm1iAZyNedSwNVAma1PYyhcBnku0Vgc6QouTn10OAoFzPfA43VdJ?=
 =?iso-8859-1?Q?mcBWRvW+aDhA788XvaQjBjsUKjCGbbWknjt2oGBU9qDLsrs8vOyOxziNnJ?=
 =?iso-8859-1?Q?CLGHnHdoE1Xnry9NA54O4nH+ffdnn75eQ+laugH/qMnV45+CJckC+Cbwng?=
 =?iso-8859-1?Q?xMdLq5MCsyhvq9FvsRPJ3lHuDLgpi6ttjzTMBKRf7b/OsTYYhNhPvIQ5Xb?=
 =?iso-8859-1?Q?BHc2xuHrSalUDyeNNGc6lMyk/cMloWiRA570SXt+eY8x3YbCPBFfkQ4qzh?=
 =?iso-8859-1?Q?HVQMWFbK7/bbyJ87/q9OaHaldXNxkKacszDHDJte4OaCp3Hl0t+xnGXnDh?=
 =?iso-8859-1?Q?vlR//0JUVNUsGk1JLvY+lDReQrfBKin7FTpf9yGzPizASUMPHzvlvFSlwH?=
 =?iso-8859-1?Q?x9HJNmkp68plsez4kwgeEKMZkrc4Iw0e5wJeWoNNswpVqTWCP+qfHLslNq?=
 =?iso-8859-1?Q?TKdfEzGwNkH7POM5hyorFGjsugqHTKTihXH6L85Rm+Q1Cxw2KBAUR51/FL?=
 =?iso-8859-1?Q?YH7rXmvNv5hVBrzJ5EhBbBKHqtWeKxFt2bLnHpYuhGCIetchIBcODcPxAM?=
 =?iso-8859-1?Q?UEeVuN9nW0An1VfRGDBuVQlO/XBc6deCI32jiW/pNtIO/SN4Bkkxqyzl9f?=
 =?iso-8859-1?Q?MJNaf+LWGBRCMLG3F2ob8YockUejnkNfas9SGYQViFFtbKJNdowlRdCcuK?=
 =?iso-8859-1?Q?QVjf2AVBYzFfOl7z7nu2Ux/pFZe2YVxPMrrABMgBxUsIyzHm6/sbN9tK6+?=
 =?iso-8859-1?Q?1db05FcMEqCxI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?avl/e4Zfd/+2yh8UkMZ4e2D+/W5EodeQZb/x240bhMF9J/E0D+nRBSMdj0?=
 =?iso-8859-1?Q?4RDYgqTEgJXSI9K22Dsc/5cSAGN7ib37OyFm0bQFxHbFR7lCgylJl10wOF?=
 =?iso-8859-1?Q?UvEgHtbhIEZjQL7cVW7bSzal7zlXGsZs3EwK5ZskNYykex1MUGGn/WefKu?=
 =?iso-8859-1?Q?9Qww4M0Zgy5URD3JVCl6eLVoWDkng0MlBJ0NPyLbSbebWDYm4EaG+RMqWL?=
 =?iso-8859-1?Q?rIwHpQCIF/QCQw3ur6TvRilPSPHF8gyS5IeusG5EW3DuoLP8tH6WmQ9jKo?=
 =?iso-8859-1?Q?GxAfhRhiKtTj5tI6VX/SdcRZ6vov+LBLtZPgpuVsm9rkjXfF23lHSjd7X1?=
 =?iso-8859-1?Q?H6nszvEIYgkHfuQvYHdec/GzQ8L5lh851E8GsvDIzu/skuMKIjQr842ZFB?=
 =?iso-8859-1?Q?QYJ3Y3BovGXbmEVgm+gibAH6SBgP/DlIHE2rYOiUMHwH6IU2wOJ245da8o?=
 =?iso-8859-1?Q?nxtPKT3tekcK1iP7V3WQuYardmd49sJ8hTPZvY3C0E6kzv1wlK28BQk+9W?=
 =?iso-8859-1?Q?h+/Jgn1ERkJX+vSRGYIVon7bK4t+uR43pC7XMGWb/zmk9KDSSA67ztRU6W?=
 =?iso-8859-1?Q?MlzHRH6n6HQC+V3ftzRyVbCsNJel41VkN8LG6tvVSwPMscqUyVe8lN0gIR?=
 =?iso-8859-1?Q?41de82L9WNnQnVldIpPsTPXgMe1w2ywWnxQsn/Te9kA+PQ3E+hMfpUGcYX?=
 =?iso-8859-1?Q?tAJ69rZT6lMF+wqK6dPBkEOX0lEg9GIfHIdXOguTunTbA69kPHU5XVvlTQ?=
 =?iso-8859-1?Q?Ku6a//Q6KMdr5XmZedLIJffLUy1BlrPY38vmrPJ3VqpvxQ+nGFXRZVNYzn?=
 =?iso-8859-1?Q?PAhISJogF9gnF3cDuxfNAL/lz9vh6cnAR8etPWfomYAm2eSxSz8BUYVMaY?=
 =?iso-8859-1?Q?eQPbG1zR4wuWaqGQhqnuxhrUC79ZVFS0UVgOocJO2ZSgIphJMeVWv+nN7J?=
 =?iso-8859-1?Q?Sn9i+xQ29e4mST7m7iMpSQ/Iur8gUjx6g4YpkAFEihrYNMbsf+tFa+shGQ?=
 =?iso-8859-1?Q?peLiQCQMZJERKcpZN+IxezKisklSDrjvJst9nLItHgpHNFV2/LioU23YuH?=
 =?iso-8859-1?Q?oAbMVqli+rFcadJfAqzFqo2Rk0uSgXnM5z73tbQG9u16YKr1Gkk64+Jx4R?=
 =?iso-8859-1?Q?nBi5tCTUZWT0FAfEj3J5pYPiYWzugpMz8bLrGJt7ah6vEXhRsjw5s8o5IC?=
 =?iso-8859-1?Q?NF8H8I2+OzYfqlBZUaEKKs5Q+OEu8/I3iaAsLfnEeXVskfkZjsGii8o5Fi?=
 =?iso-8859-1?Q?YVbSROuLdwGLhp8DYmRrSvOzTRYgye3DhAFyta2zunl67QFhxM7TldARCp?=
 =?iso-8859-1?Q?cQ06RoAHnrNmyq6lF+YNLOcDDoxd4fenYohfB6Mgl3QT2gxzhLfgOC2MdD?=
 =?iso-8859-1?Q?I6LYXedK+zca94FkbbfeQSaV+16DDBBE/kwiPyEd70cyeSv48MzME8A5DJ?=
 =?iso-8859-1?Q?I6XDj41jvGBC2N83cgRf34g1DiT2tasCemzwjrpFcPbmk1f1CbJ8lHYF+l?=
 =?iso-8859-1?Q?QM7FTui/IWLGMirSHHhUdBNS3QfMcZhpMXPwTDDkuNQpnnA49hio7Crf18?=
 =?iso-8859-1?Q?D9FJe7mOmSOBIhvDGOX7hdtI4iChPAWaVbBXjL2ybv5ABOa6k6fV27IhGP?=
 =?iso-8859-1?Q?eKK94t8Kc6w6+yiGjj7rnGc1FgKA1/cSGuUESI1rtezXA2tG8xurBdHO6h?=
 =?iso-8859-1?Q?7vzib/Wpc1Si4XEdNSYFCzVfj7VwY16Fl/pKFyxPxx0zmyg5XXZ9Nbvlzt?=
 =?iso-8859-1?Q?R49WS8CJ/43mSWbDnEYynPSMAvnHdKLfYggoARABPSYpVX9Ns4BaEsc5gu?=
 =?iso-8859-1?Q?/5bZKhqHDyFcAB4GY3dHzWVuqtBh204=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db221bf-0a27-4dc7-cac8-08de5393c1f9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:38:41.4326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVXRzRDudvxmqB+YH6ePXCCn9+K4/ncurl7q2fUhCYd2RwJSy63m23tZMfpszV7rgzFCQ8jPhdseDhA/zon8k1S8oF16HFb1YLR5/IMYHQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5802
X-OriginatorOrg: intel.com

On Mon, Jan 12, 2026 at 12:16:43PM +0100, Robert Richter wrote:
> This patch removes the line to include:: <isonum.txt>. From Jon:
> 
> "This include has been cargo-culted around the docs...the only real
> use of it is to write |copy| rather than ©, but these docs don't even
> do that. It can be taken out."

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

