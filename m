Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A11E1C33
	for <linux-cxl@vger.kernel.org>; Thu, 24 Oct 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780187; cv=fail; b=NiSUUqVog7Bs0l4Dof1pz55CFccDDdWdSR/Y40+3L/J5YYyfZDuobTEamLXx0MPAbeHNbj77AEBwVdAGZduA9+ZdAGLDygojr77DO/pa5OQVD4pjWLhT7uqkqxbn7Oae8nu8Yq4N16UlVFHuFVmJpq57dnphFwVGdegDUxjzmCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780187; c=relaxed/simple;
	bh=p1TrhuaNN96Xq4aPh+g0nH8BHpXFOKbirFncXYm6A5I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zp5Svq1WI8VkPmO5SeujG7C7kf0O1oEz3+hV1QTakL1/wDEergyN6K4TDHIMumY8my9gepz5iCqt5QAT93POqQNrwo0ZRdZ8OCTCm52neRTLwrKkuP+81Oo4BV5wexGjsIKRwYBZ0GTL06wYvFec+Y+uXA9+x/oNv4AAfSF0QVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3YZ1hFy; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3YZ1hFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729780186; x=1761316186;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p1TrhuaNN96Xq4aPh+g0nH8BHpXFOKbirFncXYm6A5I=;
  b=O3YZ1hFyjDAJhalXkwSn0nBl7qaAlcrf8bQILYMsV3BGIQwE6NdIJBIN
   fFpp1SMIlJLw38h7GXBzuLX/pFViMyRWWWPGyADq3zAnf9TGTUV8nDlCD
   DrXB67ud9wIIeRft5ztK/8cQFYbOFfGFty8hBzLIzA+WiXABjn+lTqVD8
   TjePov482NQ4++unPFy1p4gCf3n7Q2TmSInzWSs8zC0G8Q0DOaxorXZGa
   +9oluHYbnz8vkzkpVLY9wc2Q3W6WD8HcG2Lm4auY+xo6fssVeK0XZbNa4
   zgu2oAPGLaEz+sUsst/c/QaDmf8abFaJdiOmpdZcxXPlPAeYgde7vMyiY
   Q==;
X-CSE-ConnectionGUID: 0J2jSSdPQNyCWa9Eqa/Weg==
X-CSE-MsgGUID: +GhOwKDxQ3GBV01Nn7sEjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40526913"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40526913"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 07:29:45 -0700
X-CSE-ConnectionGUID: /+4uJXzdQf6mnsNQNypdrw==
X-CSE-MsgGUID: sUpIPBS2TDSswOcdi45cDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80897500"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 07:29:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 07:29:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 07:29:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 07:29:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxjDoS/LGGeH8MoJcOgbaAIVjuWhaqF2IVNIK+X3cZiLNViZSJDvFdLP/qw4ITkdApx/UnAsDqOoW1Ibv5PjuSqAA2ryxpbp8lXpve8TDABwH077ylAEi+JFl1pSDpo6icvJtp8KyYdE0RgarlKvUEQEfYiX7GH9czPyAqVkwm/BOf0P+8g0oCFriQav3VpxO9qhtNOiX/vjBy0eYwfyF+L85Jfxh+qTrMxgTA6GPIXwaQkARIVuk1oLnJ+DAWDDmCJECdBxGzL1jYtVBo/ViFyj1OdgE/txlAKZOkpb5orFCxi1M3rFz/7MGHoZZiolCC8NtN9AGyyLR4WByhGDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xa6sshOxKFzF2D1haPY9a6mrOlD/ERagqDKwxd1GD/g=;
 b=Hzyt9yK17VWobVm4Vz/QbSbwdLAskrGUn2viLvd+K1YK3tTRqXoqNgfR1puVite4SHIyFzTmb42VELnbYrt5xvjdRpGrujCbnOoBmFEWPX0cm31Ijag9jy1km+ez83HTmL3O6dh+Bfzlrzltyr61BVgerbsGQ6Gjh+Vh8HNhlbg9Eo5Z6gX9YWWwCn+VeKGBD+XUUXcYWkJoXyRcq/GBetaBiSWjA7exA54ICZx991YZUiLRfs66Xcmy4AxrBgfISWZtKaX5dZUKBaOEm9Ujy/lUvmHzXMwjPHP9vmK+hv5FY2Fw56ywm1vXKtREVi3rc6ps1oFjpmxDEw3BFVc0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 14:29:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 14:29:28 +0000
Date: Thu, 24 Oct 2024 09:29:23 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>
CC: <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] cxl/port: Fix cxl_bus_rescan() vs
 bus_rescan_devices()
Message-ID: <671a59c390a88_f5b202943f@iweiny-mobl.notmuch>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964781104.81806.4277549800082443769.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172964781104.81806.4277549800082443769.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:303:dc::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 24dc127c-c05f-43d1-0ccd-08dcf438441a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eYhXyE5FUi20Daz8WQb+WHYI/HN3UtN6g2WHrQubKkJbjT9bLYmppGDkt6JN?=
 =?us-ascii?Q?jdW5PZm2xGHWHNLuWniff7Nd5THiJSeubWf+1eZsSJAXOeB90TxW3OHMwuYy?=
 =?us-ascii?Q?isgzSQHia7T0n820woWSCXP0x86tuCXbjkF0IsP2JxKLDIoDhDLRfKweXK9l?=
 =?us-ascii?Q?5Y3hf1lLVCfPsqoOQh47Wk+qTcvtZu2iWMjvx9Xl0Xraqe50yNAVxFYCC87z?=
 =?us-ascii?Q?Qw/5SckyNL5xzdw3spKqfisCFDe7MKcY7hy72rK4DYkkJ+DGCNiBKSRaz+3r?=
 =?us-ascii?Q?GKXIFDQJfS7kyOEBMLhtUFulcct2vKr9A2X71d54dh3z5ISooXFETo6ZAohM?=
 =?us-ascii?Q?x/y4g3sn5imFaAqEl27JtFkkKHENj8iDL5RAPsc+xqbgesP6qV8Qm6M4UsQR?=
 =?us-ascii?Q?luW6+DlZtJEZouulId40Mx9DqZaS2+CP5eNs4ZQ+omR+TnbaoDcBbKTnJhaR?=
 =?us-ascii?Q?5lAMfGMn70Tf9E4+jg/SLCpDMxqUGifwrxxg2U1ZcdvWXm7GJyuOaGfC2A80?=
 =?us-ascii?Q?SvkEf/2iXVG37kyUSGuk3Bag/qFrJLKEwsdhjkbEyh0WPXAgpeetrDs4A4te?=
 =?us-ascii?Q?Z0DGQjsTWmrj4gg7Q76w15xvkRVhf1NY/QIyl+YzuJx6jLAsUjRwIrdMbAGz?=
 =?us-ascii?Q?gACKo5W0jCS58Dvom38qrARDxaHKi1xi3J0Q1GPf4xEJend8z91vg2O0gS4Z?=
 =?us-ascii?Q?iVcv1qBaGU3P8V7OgFdHqO4LcUqFONmToJByxXagGEaWrcJr0WsP8NE/Z6lS?=
 =?us-ascii?Q?c/emxW0ZWic7LhEtRNstBql5iMUU09ryoVxtzPSBPESAumUBs0K1diCAlKJH?=
 =?us-ascii?Q?4g5HjjObQlC7OyEApxRZHdpFGf4D1vVnzEJoTBrp/KarHTh8uz/8dm8oDDFf?=
 =?us-ascii?Q?IOPz92DZf5RANMM0TEsq4q270pVU2HrzeP0NfBPqgE7h0s139ff8fNov0KzN?=
 =?us-ascii?Q?6nOYg1igYz2FT8z0DWJC98CsHlhtgtuMvUNptMRceDMTZ+Kj2p+9hpQb9FLT?=
 =?us-ascii?Q?6SELJDuSQ5o4WYZuz6hYyO8BI6YrlHldhjBDuwdQ+Xwsn6UROtHOR3AurtYz?=
 =?us-ascii?Q?MUfTz/93CsaPFYxVsilUoTXTPHDOGFeayzf/ONuLxM98cXBXqU4uoQdK1YK1?=
 =?us-ascii?Q?VXISwjlr0yKdwypW6WjbvLMnC4umJjqj5OaiTUyUQ3fLpVzMn/UZz/tL3i8W?=
 =?us-ascii?Q?dWfIKOT+hXaQei4nKEYtkrkLmHJBTkf+4dlUFpyjk+u1wlZ4UlGuJd+vPIyI?=
 =?us-ascii?Q?9u5LT0VBIYF4hLHCc0KEycQ7qhl/0GvbMUU3umtQkS9AgB+ao2o6UBY8OAi0?=
 =?us-ascii?Q?WVCayArD92lHBLR73ofTQe+I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lIPm3aXf2pS+I7Yv7OGeuiHXm1BY8oVVtPouFkin8z7n3scJDF8tdSQyHZpJ?=
 =?us-ascii?Q?xMN3tJu+t9FyWohkjxveiXQAv9lkvOmIuXR6yJxQLHsKNvi78c1RU0XsTMiB?=
 =?us-ascii?Q?8M3K7Uo2XrKP1J2gCS9y5xVPADuet34OPzv7cUdplrbn4A9/A5uVLb6RzvXd?=
 =?us-ascii?Q?MbjoQb4vvkbW84riKdVNpp3FGO1aGRypDmtoKAJLdU73SSMsrEdc0u7A6EEE?=
 =?us-ascii?Q?HjV1e3qahH3jpiS/IUAaTuk9NZqSkmeYbj2FO6llnN1cCtKa9GuQLf/a0VRJ?=
 =?us-ascii?Q?dEjes/G0OK/7zIJVLzL4LdDymK8uv0GLsT8NP2fEuoNNw3VHkc5adypdzSW2?=
 =?us-ascii?Q?7pDjYqFJsvQ5jQmwYOJcuam0yQ8N+uPpHgplIYwvZCTzzka7G/rnN4bApRkQ?=
 =?us-ascii?Q?ZfNGpMM0AHrZvTsNzSlQXVwbe983rMyswTDuPcdAdzN54pOFpSHhoWehM7pg?=
 =?us-ascii?Q?mIUIp3qLXxCNDiHJjb+CpgGjbqDgjpfBRd3ev651pXmBLK93l+Vo1cjeto5e?=
 =?us-ascii?Q?3JVkloYCuykjvB5vgkkOREZPwVTjhCZ2ssOMyoRJU0JfNqqAKgI2n71p8NR7?=
 =?us-ascii?Q?jDwrTHhWAot3g44KSHnNrGA0X4Ksy/+HLgAqUJJsW2ZWrWKMc5wZc25qaL29?=
 =?us-ascii?Q?PC1TTBDCcszK0TEjpm5tt/hbsMnSksaiNmuCH1KJ5/ElEBo1z0sJ7AjV0Ton?=
 =?us-ascii?Q?uwyAEeY6EWBRdaaluJfrdgin/SVLPD3F5c+3vVCbIbAPFGt+G6EKMV0KMonc?=
 =?us-ascii?Q?4YmIkMrp9a//yah6++jehdeY66h1uB+NeXnc2lHuK90Oap8Rvlezf2zfBpCJ?=
 =?us-ascii?Q?w5B0AAa/uAgnAqsAkP96T90IQnvyszj16HARVjNJK3lxdXBz9NipiYKMLyAv?=
 =?us-ascii?Q?cWsvk5zTlEgl2oPKrDvI8LYuEiVahieRJUpeXTDLqjm2op87B5TzQjzxKDtE?=
 =?us-ascii?Q?ZdDgIyEdo3UPFSmX2UyNk7d++DzyEFXQWR1sZH5HzStslcIu8GNyMjOLiAJj?=
 =?us-ascii?Q?BQOnbXMRBtC1cUjTDGNv8JpsHXntgWkw5kj0wat+vMz7eGXK6Gfi0PusGbF7?=
 =?us-ascii?Q?urmt/PfOrsBOWwCnX2ToZUztq+EK6zGuIbqVfwr6Stj795rUIpturrTiVhya?=
 =?us-ascii?Q?JN7NLxPBNaeIMB++rAcW+szxye2wr32LFqDpzcUYXqVqx0mz7+rXrPEceuwD?=
 =?us-ascii?Q?TYYiGZV8oNLkGGDgzOSdxk1o47vzK0jMxsG7cl4TVSVYegpzwBO8pywX20Hp?=
 =?us-ascii?Q?EclqN7nkbWxPv8Y22janDCMk/LrsD2XUbt35buZLqMPx6h4e05EmXBP4pvZy?=
 =?us-ascii?Q?M+5Iguyza4uO07Qj7FuemnwD0euPQTP7jXZBmtBPgBYh+tZpbFzvBdTNayQE?=
 =?us-ascii?Q?ksjvQgzzPOdCZWGqTV8OuEJOjdE+GcfJuIsIeKsim9kUBUjlANREMeFX+7De?=
 =?us-ascii?Q?02kU/cq52t9gHjn3BMYZ2dfnR51xPPbyGyPaxaPjo3scdXQD6bTrUdepirhp?=
 =?us-ascii?Q?ND0Ofkp96oOsAM2CtOGmylLeuc6yBLP75mTXIQNvb7PHJV6/LCmEiKoeaH3C?=
 =?us-ascii?Q?Zn7aaYexttUWQPABENB/tOBdjQf6vI1GAMjdo0yB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dc127c-c05f-43d1-0ccd-08dcf438441a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:29:27.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATzliztnkxTg70+K6peV5baTZG2pz20XESqAjnnwq+C4GmbOx5vF8e1619fZtMXJ0bMu+9KE8p8S+A2eTKKN6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com

Dan Williams wrote:
> It turns out since its original introduction, pre-2.6.12,
> bus_rescan_devices() has skipped devices that might be in the process of
> attaching or detaching from their driver. For CXL this behavior is
> unwanted and expects that cxl_bus_rescan() is a probe barrier.
> 
> That behavior is simple enough to achieve with bus_for_each_dev() paired
> with call to device_attach(), and it is unclear why bus_rescan_devices()
> took the position of lockless consumption of dev->driver which is racy.
> 
> The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
> is merely by inspection since the bug that triggered the discovery of
> this potential problem [1] is fixed by other means.  However, a stable
> backport should do no harm.
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
