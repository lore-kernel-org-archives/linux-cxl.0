Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED37337FF7F
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809321; cv=fail; b=jIX77IVdD9Rp9dHmDqscxceVziEwQoTc/DqaFA2yA6dNWBeGVoQHf280DWtKNcF+g9LLbGZzSfrrKRCeOAXrNII1n+RsNixetoPeioRcwSaPdRoZUI/jpKyRjdOOGSj80Schv2E8eMqiCCL9BCEl/h25LdULLSebrW8KsmeWMS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809321; c=relaxed/simple;
	bh=A9aN1/T7W+O70mCIs2xKgBZJKTJXtrdq8RKMyBgdMzM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a2KwOHYOY0etoWtQyBWV87a2TlL9eLEZDjvc9K0wMVezIVgF92AZFyWyrjBjbmbVgL9W25DAOajrldy7EiGxQby0A9bgMFeGhCVEU/v7lZRzB1qQrgbj2xm8vePr792SDJPlUGNUjaGrQa9jDWEJ6S+fRxXsYIqgzO3LwRRVLio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmr7apq+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmr7apq+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790809318; x=1822345318;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A9aN1/T7W+O70mCIs2xKgBZJKTJXtrdq8RKMyBgdMzM=;
  b=dmr7apq+Ood0GHYE2a67mUGPUiej9ecpLRoXlVuXSillOHG2O8cCWljp
   Wkg2I1bf3LfEBLBlMmzdhOb4ijN2Srbj0FSevfA1a9N8gSgsjiPOGkiP7
   pJoAXJaUwLp7pJ3WdQRpadCqqZfXjPpm/jAofiv9KRtukkVg8zMnkpfWZ
   egVUPhbKVeTUmxJlPihK0ZneXIhCBz8L3Bq9uK5YbmUiNKo1Vd1TpFdyZ
   sMyRuIDNQhivkWqW3PwrAVYGuctvmVCbbahdQSVQWmISKAii8OZ7/bfWO
   bSX37NVNAdi9B6UUuiTeyw89VTWEVHat8ua5E4tL4tH9grkJXxxtM3J8K
   w==;
X-CSE-ConnectionGUID: MZ4ycAbrSdyA1yraP6vARg==
X-CSE-MsgGUID: ATTMJycwSY20VMx1ZH8aSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91658167"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="91658167"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:01:56 -0700
X-CSE-ConnectionGUID: I0fIlagETGOnbjo1Vm/JKg==
X-CSE-MsgGUID: uyrJ1/mfQOy/sCT00QkYJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="279032502"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:01:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 16:01:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 16:01:55 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 16:01:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHaVKponcigmpR/38mKXgNxLrU1f9KTaR2s/NAWELcpvP4e2m3nIyWNs7tKZd6A93hRfaTZFrLAOuvGIhNWAHQh7NJy5mv8cgIn3hELdaWxnv1nIbSJjtPEoNfV0uA8l+ozoeDGPD9A25bKR4G1Nb9aGTtt7YML125EMWpw7r48rlNX9QYXsH49f2uJ9XhDfEgknoYIptiA4503fAfdiD9IugPlpP+/9Ku4X5BlssNd4Q6yo24fN8FOak6iwEqnOjrGrjAqpFqcifjrZ8OsT9cpCvOk59x3Rr6YPCEgdThhrHGdHkwzmVCZHIiuLZR3hiMY3eZEjB3r2DvUh9Eo/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ivev09/bNtB1Elz66s1qG93b8cV4jTDSZwBJBXVLjp4=;
 b=D73U/d7+0owkIagFMF+LGtHmGALqV49MeEqr+W/hqY1q1obMAwEICqHJweBo08itCYDkcGt5fApj+JNALFYZ1ZJ2fICfGj8Mki66SHLv70B50qpkDTRpyhkVeBhEHK01lqDSOZm1gg3gNL3Nm8eSzVB/Bk1tWQtoSYAJmaaROKTiaGQKk4u5ApceMo7e2RX/mzmuQbohnYwkrEUZ1yhUyM3HySArVstnr1s/48Ul4Te9xdfjv6oxXei/uZIcekUZE8GSAgbCh+Vtx07nNMMihErBt6ot5lmvFnzp5Vc1/2Cx8dEhYlhRp8O5d14R15vaDF0Tr5JlAV6cOM3/mb1lkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 22:59:46 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 22:59:46 +0000
Date: Wed, 30 Sep 2026 15:59:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<ming.li@zohomail.com>, <icheng@nvidia.com>
Subject: Re: [PATCH v3 2/3] cxl/core: Hold the dport host lock across dport
 lookup and use
Message-ID: <ar2UX8QA7fPcOiqs@aschofie-mobl2.lan>
References: <20260930152311.4164036-1-dave.jiang@intel.com>
 <20260930152311.4164036-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930152311.4164036-3-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR05CA0174.namprd05.prod.outlook.com
 (2603:10b6:a03:339::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV8PR11MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c56dc6-5cfe-45b4-11f0-08df1f4685e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|10067099003|3023799007|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: jsrp7asoPPOTn8lJ2c9qZ+xd/DUWnZp2T257+v5yN8nD7+x14KKAk/JmkyfwTt0lvD/Yq5DFrAqiDdt8wnSnKJIbr1WbAnlZXJSShYcal4L69djmuKAEEx/PUnzVsjoESOI+MIrHdc1EPXZrEloiv7sY/p2khiM9VFs3U9LmDREDooPo+rWhsQ50t4ue2ZJHT9JVMbllK0128wLXP/ELsavpCjMjbPsUH5hVs0FYOrGNRpqnF5JPO54CcN6jgpSWYWnaKxXWBdtTRI4YOAbzEzRo/Vyx4PLAiFA+dn85nQsdEv9CCUnoQ3j47W48S8xae/oJqWmK9+SqOGUaAI24cTH1qtOUoXIsQCQBerJJyseNN5h/LfF73FGH3L8VP+BOyYvukaZtj1EzSA5J1ByZhWRN+eZSbr+5nhDW3KDZ6IKnhR9LU6DWsiiA8RotxM+moGKuFByD+J+oznRGJAZnssTnujgXXYGl7G6BnBgLCNpumSjwF/DtsVKHQE/v/a2CVKOSC3Szm+tZ5LnrT17ccm504Ow2HIcIWddwvUbpR0Lyqk6kM3TAYFZFOBJUZIz6wwN/rjp95x2jstiz77ZuuRMKG4UOv6IrQr6jQ8hdLu3KE4sPEodeYFXPtWV4oCDBgyUl5GbAgynuwZ7heeeLhXNeBNd25KjbBQy4Qbs2Nro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eY4dqe+OPQwWzoTc6skm1vIgleCLbzMx2hVPy59wh6lClM8bPgsmNyDzdE2I?=
 =?us-ascii?Q?aCPWxZPUPG1/Cr3Mfw73zxmRhBLXuIP+fGKVi+bUdD69nB02vbZteOPsXbLu?=
 =?us-ascii?Q?7bdKKmXOnQQqErheCcib6XVK4uG5lEvCAMuxHFNs3xZFJLhxV9cvvcCLI9Ea?=
 =?us-ascii?Q?/b3uAwdRAc5Sb539C7b3tiw7HXtX/DJPKGJEcnT2PdOb4wKewbXmwEe3tiAk?=
 =?us-ascii?Q?yhtrs5/KDUwzKZGkEi1IlQXzAMnRVRWKZU8vwzGWr7zIlFrvYw9gAmdTZNKi?=
 =?us-ascii?Q?2XCMnucWIIPOlrLw7CvDDY9S5JaR6iJOO3tmJ6Mb0jji4LpMSERMKe/oOX4d?=
 =?us-ascii?Q?H8mmP1GCCes46pawH8AKgW7BqPWY8ujUtEMXUFKrvYjik5oCXLk9ZKYFvED+?=
 =?us-ascii?Q?qTW4bS8C0K+shkjb+/UnkjdKUqWd7dYhATxGURzGLF2RY7lnsue4f1ZyPCpr?=
 =?us-ascii?Q?sLOgWA//W/zypd0MPD4jalWqbLY4NTRKrk9Vg7qs+C4d/xRCrhu8kV6nZdv3?=
 =?us-ascii?Q?Az9kPhJwusmSwIgxNBA/BJswI8SSGSB0xzzCYkzllGc8w+w6L4ldqb0zaXjP?=
 =?us-ascii?Q?dChArOnNo3AgwZRUuABIfJoduQuPjxinCN6FEn4rarohavjsx6vpXzqabobF?=
 =?us-ascii?Q?UukYJEvZb/BDwExrFMJqmZUQq56fpHzsmXQliJGVQfxHb5hkGuxY1XDPG0CZ?=
 =?us-ascii?Q?UcYI1A7E2IEmpKuuSRiLRrumFT44QLKBkzHdDv49OgGRdXevy5rvZkXJxXEi?=
 =?us-ascii?Q?y31wGxFItLM8zuFO8jO3Vob+8rKo1mbFLa5SVVWaA4HDTgcR/IyV9qu6fl/k?=
 =?us-ascii?Q?/v6GK2rQdgfEmk2Yd3HEX/+je9ckTDNrfK9BW//87rWXVawrkoiQl4aoBPHw?=
 =?us-ascii?Q?L7g12QaQUSoiMAKPrnFDNESGeotKdZvHyP4ZCzjWV0W6TcLwyCahKjeprWWr?=
 =?us-ascii?Q?ArF2QYjf1WA7f6EDEWubRzPW8N8BnX913pfIbj3KHMHgdsARLDRh+GN2Hz3Y?=
 =?us-ascii?Q?2FL22vuWNseTcbnO0N7he5vcrBEioYs4QRls1Ekr9vpA3h/fnMcIkiVKep6Q?=
 =?us-ascii?Q?uXWDrSSwMWfLmwC7Vbl0OOkRukEWX7bnwzPFqOxXG0MrHVx3ZKIqEaBsNDVR?=
 =?us-ascii?Q?6P5jSHCWViGUVcvyr4NBhyRLaYJu9pMT32+YtKmaKfrR5nvjQDx2fnKanAHX?=
 =?us-ascii?Q?L9CwUGJvmrPs7K3OxJvqFimD0cBvE0J6U3GxHMsj+HZGuUA3AlIosD2v6vRf?=
 =?us-ascii?Q?qFC84tjgBJpP5ViM7mAlAhJfWBBPCtklrmGVdjj/1kHMHcaKHvu/VJcpjRPF?=
 =?us-ascii?Q?vsn9YFvfOdvUrTkrcFMBAJg9k+/mCderYbmmBLPy+1cNArgv2kSm+H4nUFnR?=
 =?us-ascii?Q?Y8PEN2ycK1fsLhUiMqyRU6UUwesHr+bCCFJqp7RmgE64JB3yqEVNIdoYOiLV?=
 =?us-ascii?Q?takmg2Yzx9vk+nSWHcaAiJ+jQRclFfW63dKyhs85DAEtNBcstyf2K2jiLy5A?=
 =?us-ascii?Q?1/WwUiebh+HIa0OLnlhelO1YsRLlfgz+HO+HwfEH5pTKMq4eblYgLHk7OKV/?=
 =?us-ascii?Q?bw7M0Q03HuuykVuF3zcAX1vTgTKpYoYka2xHvHstaM352wD5fN/3NUUbYrs+?=
 =?us-ascii?Q?3QfYAqS/Po4ud+7ZGf1YnBNC+qXAEzqeV0UXYEtum6I4iGpJoNAxgA28Krrl?=
 =?us-ascii?Q?ykBP1sB5EUm85dO7V9omyOhgUm5yJ6qE/jpJVXsQCxSELLmHtwsILdqbmTVs?=
 =?us-ascii?Q?3LSME0NtZMEZpHouB95NvxvyLPgZIJY=3D?=
X-Exchange-RoutingPolicyChecked: jzb3VDlSE4qWpecg4o6Ei9NwvOj6cTK2ROVWqb6LXuQYq5Kyp2k/IWyRrwOIZ1zay1P8Ey2kaV2kPrbGhsei6DC7xrlGIycJ0dtdfAMdFyfrTFnKxiK7ygIvfxjcaltoHiVYGE5Rxtxaq9kS7tnL/dVlGekkKMiqB8BoGVgtM+FmlDlusUMSltQaBOqXBt8uf1b+ZAbUptD2qF43lLoRfppd5lNfM7Itd0Hoi9wbZIYEufsxiSGk47QYs76l85N2m189WoYzIBI699/Z+BKJBbAYz2Oqq2aITacIbM5KdpdViz411Ra6Ei5TP1FQxjPcWbLvRdRYcWteLUjRJ0wtyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c56dc6-5cfe-45b4-11f0-08df1f4685e2
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:59:46.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsxXG9dv5yhaNoGKwWWt6CP9zfRTSSf8S4h7tCKyzOwg9dqo0jgjj1yUFzkDEjNkGGFifvU/5UwD5gv75tiPrv2s03Fo3wCkEBZt2QHZvWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8722
X-OriginatorOrg: intel.com

On Wed, Sep 30, 2026 at 08:23:10AM -0700, Dave Jiang wrote:
> Callers of cxl_pci_find_port() and cxl_mem_find_port() can be handed a
> 'struct cxl_dport' that is already freed, and all four dereference it
> without the lock that would prevent that.
> 
> A dport is kzalloc()'d into a devres group on its host device, so it dies
> when that host unbinds. The host is &port->dev for a switch port and
> port->uport_dev for the root port.
> 
> Both helpers return the dport through an output parameter. The caller's
> port reference pins struct cxl_port, not the dport allocation, and the
> lookup itself is a bare xa_load() under no lock.
> 
> Add cxl_port_dport_host() to name the device that pins a dport, and
> cxl_pci_find_dport() / cxl_mem_find_dport() to look one up with that
> device's lock held and asserted. Convert the four callers to use them and
> bail if the dport is gone. cxl_port_add_dport() already follows this rule.
> 
> cxl_mem_probe() chose its endpoint devm host from dport->rch, which meant
> dereferencing the dport before taking any lock. Use cxl_port_dport_host():
> rch dports only ever land on the root port, so it selects the same device
> without needing the dport.

The Sashiko 'low' issue of dead output params sounds worth a cleanup,
but I didn't look far enough to know if it belongs in this set, or a
follow-on.

With that addressed or deferred - 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

