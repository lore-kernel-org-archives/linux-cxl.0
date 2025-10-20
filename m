Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF01EAF9;
	Mon, 20 Oct 2025 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988633; cv=fail; b=Hwxjr1oc+A9ZH1vohVzV/11ravGVTwBkVkKsi608q5BeMT/xYXWPBL2DYZZ6Y1NFMAk7F3iA9fevll0vn1Y5XnABWV9oJcpKahXa0OJHMOTnerbIYD6QyRNKP6RRTTPUoX5p83GymHMeGlS8uUESwu4MByJS2ldHx/oq8So7+3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988633; c=relaxed/simple;
	bh=NGoYbCa6Zqo21JU/9eEFw42FGQRvVTyb8pQ7YsBcS90=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Aazk9HwZ4JvFSxDzC3/nQ8VoQtkh6KTjM8ffQskSibQa9H5ZxGd+/ov04BOzClW3lR56ekPph7VXSkUxU+nTyR4KUw6TgCqTx4IXwnUa/pfcDBIEEUck8yqrDefrWM/NYVwEMOOMWfW/fOf3EgNuslpd1M2o3+HrzAG5pPLAGBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCJyvrGo; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCJyvrGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760988632; x=1792524632;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NGoYbCa6Zqo21JU/9eEFw42FGQRvVTyb8pQ7YsBcS90=;
  b=WCJyvrGo7e4sYfLNNm+lRCl7UEdHsgczEYwuLTLCNUxtIrOrcjdSGA+a
   T3xwts7Pg91k8YzMq/RMRJ6R50VWtZe9NAThoKWvOSKjHhZNjUOs49Ov7
   k0ktIjmX3sMqxPnHdLdow6eFIeu6z8ASE/KTVFA3iMMue+HoQmJnjRlGy
   ZgOONqC8uZM4gILuPHTO3K5RosGEKLCzwgyNoN0WO6qr6G0v97goyLLCp
   rZ2CUtwo6/QPEpgtHFBxDsYOw7LdkCYUwKKHih5G1n1X/lI/vP3T9mpYV
   akApqKUm6STYrTT/ZmO37hRQC9ZzmfkAN2IK/YfAqPHq4KmoOvWHvf08O
   Q==;
X-CSE-ConnectionGUID: r2C8sSRAR621hoP7KbtRTQ==
X-CSE-MsgGUID: i3ZhTu4oSACAjcLaEpEppA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74454965"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="74454965"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 12:30:31 -0700
X-CSE-ConnectionGUID: 0BsFlOSzTTGd7R6qBCJ4vQ==
X-CSE-MsgGUID: gAqrlLRCQdan+dkFrP9pVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="188505725"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 12:30:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 12:30:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 12:30:30 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 12:30:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB4iz2H7Q3uIficMmz0Nsg2plGnQsvExTGRN+EMhX79HSncuGya4LjeDqd4F4SYJ3yujB9Xj9+a898H6zD1/+ZbMtnSfWaJWXaq2aSqJbM4N786nVI9jIxvxB6Vpzu3LeS51UC3sZWL4xGha0+TpbH+32jpzpAyEAOgnfLubl7Wm8KWtL+b4qnVURMH+jtq5Ju5x7JcxibntKCRLw6RNh/8AH+UjjhQk4sfOZP3Cu+ugpk9bn185UhF1ykbKpRhlq+KKns0RDyNU0rBBpXlZ+CxYxYcp67ElaGwjn1oNpveoEy9T5oS0V5Lv3uiYhVvc+rbOBqkEkVXvZjkg1L+SvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHhCQ+i4d6SAMugFphSX7D151fC8LVWK099Dihd40ws=;
 b=XtqdltAINJ4qfmd9WjqxYvSbqiEoizYLvLkGMG/stJOMVlk/aj4rAuLNf/5pOeFPiojZVkUZuEGx+KyoM1Tr084UtLhOXX12WTfFOqsXBij0NRO36UJaFxq1mj7+LrYFvJtchSEtzKC83vrKdACLegfEOnPqtFVZgn5xWk2d6troBW/jn/CWk/vOdfT6qsL3Ca4NdcSvwzSKUci3JXFNZNbLHIzQ/c+epVUGx5t6xs3FrdBJEBC4juKbvKBlE6SJXdvnxDKS5Ch+6Yjq+5cz7vjgX15mfEYUqlcdFCO76MUxUNXtBTPNCa9GEI0J72CY14pPUm9adOXdIgsGL1JTXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:30:28 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 19:30:28 +0000
Date: Mon, 20 Oct 2025 12:30:21 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>, Peter Zijlstra <peterz@infradead.org>, "open
 list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
Message-ID: <aPaNzeGqUHf6gGIu@aschofie-mobl2.lan>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-2-vaslot@nvidia.com>
 <aPXgLp1Em6wKlx0t@aschofie-mobl2.lan>
 <aPZE3Spas-IvHmfd@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPZE3Spas-IvHmfd@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: BY5PR16CA0036.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::49) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH0PR11MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e9acd1-132a-4df5-ea65-08de100f1fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sYQ0jF+rduTdfZGf8cyQRIZEV4/1jO5gOgt67P5OLOcM7nzwGD/Cehq1/fJq?=
 =?us-ascii?Q?/PQYt2Qd4GOTizmHOYwombnEpfzYSk5WKzFWxPP61Z5AuVWf4DHbmZdKNQih?=
 =?us-ascii?Q?bC5PZ2kxyA9oxff9Bq9tKmXRDSmO514NwBgO+d/ImdbWe2gYLrYyCDWczHDy?=
 =?us-ascii?Q?pTaJk7joCZVlH2qHWj8DwHvSzRTKM4MkN+8dxo4LXrd4bDzGKkdHWZXaXXY/?=
 =?us-ascii?Q?RrfXMLehLLOaWnNxrFtMzmsFQcb8LnMpjjGGyVg85A5ksjOAOlL110h4DdtI?=
 =?us-ascii?Q?IAyqTd2oal+b6trdWtE6fmA3sZsyFcpjY8QP8d+ETSNd9SN7/eHoQ9tQTMv3?=
 =?us-ascii?Q?v+LQXqV0LETW4iqDjgeZOAv+IpuLQsFFpE8Ff7wuI6AZOpMDgG/MbLEdYTtA?=
 =?us-ascii?Q?MJOenTwhitbDZE77ZwV1vEfGOamz6Dt2A+aYg0zcJY57HPx2XF1BLTJeqMOF?=
 =?us-ascii?Q?LhYoJTu3V4nB5bMpnuB3ccqDsQSYIKoe1xQ3fLATxLlyyGv8ZIBMHcAYTs9t?=
 =?us-ascii?Q?PCMv9oXqblZGbTRQCzyIbahWd5/AAr6vvKmXi/8wf4gMP8Wxj4DTuw16XhJ6?=
 =?us-ascii?Q?xj0ELsG0hmdoKc+CjMTOXIHPOVPVHFAoABkzjtnCR0+mxaaHrzuCZf0gv4+C?=
 =?us-ascii?Q?um+SrAZPaZIdhrJh3XUHcudWUYRS0Ow+k7y+aMLGMk6ttPzTPCGpdT4geYNd?=
 =?us-ascii?Q?R3WcFtx/t6EsXTZz62be63QnqtDk8bVDhDPGE7K8l4/yfUAhir+7MoGdHgPD?=
 =?us-ascii?Q?FDJ/RMrJgiPci2/qNpt2y1W7heYwpsI+uj1bn0I+/57p0WePdEIPIDrNdrDU?=
 =?us-ascii?Q?bYOXfVj08CbEw3vTKGkhm2ZqVSd/Zteu9LSCyZDbPV0Q7+7Sd90pjFKQIefK?=
 =?us-ascii?Q?g7dRJpvF14TRCy84Vy9GRUNsVan0agfsawv1fatC9Epk/p9OsJmf44QBzP47?=
 =?us-ascii?Q?7hBJW6ISDzqVURT/URRoLxMG8qxGlW8b/mk4t3bDF6ZKBV2sQHxOSjxbmS9q?=
 =?us-ascii?Q?L2cwgYm/1nBrUxtg4LznrACPGdfQJ8TLvx8MNDRrSVsC+ap7zf/Nu9rg1iW4?=
 =?us-ascii?Q?QBr8iB8tRB78gkrvn9FR5Mu2faLQ3+UYFIMEFEQqH4RWKyDN0lqFyzA9ZakX?=
 =?us-ascii?Q?NSCVTdq47BfzNcGds/ovHd9RP6NeJpq9SElzDIlxD4+y5ZwGDAXtu2IIhjiv?=
 =?us-ascii?Q?lqFeFJ6Gr3RiMQuI74YhsJya1sYTtK+gjKJYAcBhdDYpDacwbs6dL6mVrlT8?=
 =?us-ascii?Q?UqpZsKBOw1Lnq4zG71GTBmgv/ou/Y2HF9Qm1N90UmR2khtRJxkFpUFhUlo0e?=
 =?us-ascii?Q?223yv+HPnxbbdVySFjAhSVzc1icqejqRrMwZRjKMNenWkhRANBI5heTwke6v?=
 =?us-ascii?Q?edSh+3T2NvadagJI830uSskdR8PoDJWJI6Pq4C0LJh8G1xaW+6Xs09+b8LRJ?=
 =?us-ascii?Q?9fshhYY/CCstWqLf5Mt1RDNIrI7uY5ao?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?keu2/s26I+XcnTCYn6F+cdEmXnFjtF66gVKC1goGOefDWS5splxZBYctw+4E?=
 =?us-ascii?Q?SRtjqmJfAq8/X6/3gSwWPLezx4w2cTjmJ4faaPKIyMzlxI/kCKkYOOkcqOPB?=
 =?us-ascii?Q?eOfFzTv0pLfPK/8fgBhjPB9yzqBF1/Leq9CWqhsOFrW2bDr9EdcRMsTcCH7x?=
 =?us-ascii?Q?qdFJy1Jm9b0JI62VlBzBA4BJhPzWQh0ra/X81tDDL3kOTxVToOYOyVHof9gD?=
 =?us-ascii?Q?0iQ2ZRiutaSQkUTt16xiJdZoWUVcZayHkyRaXA12RQlpVGgRnBtwjDaJqhrF?=
 =?us-ascii?Q?UE1iw/LEYXag0XqCzedUhf2/r1sLhwlZPgMwYW+tzwwaXZRcOKFKdxT/QJL5?=
 =?us-ascii?Q?FKMqCZkQ/p7cohAACyYpdO1KyiJSBVyBcXMTz/N+kAMvLOBvY5zMkWQJia6c?=
 =?us-ascii?Q?J0ziD0+CO57q9OTkfjIiwvUsz1oyo0gSMbwJAaJqpbqAyJcDL7Xar/KZx9BH?=
 =?us-ascii?Q?HIiyHnSEJ0psG5oqoYmw/e/mMK+rriQVj2LQtg/hx1tfx3GDQ8GUCfnnloHz?=
 =?us-ascii?Q?iIlD+eN6tS8ZEfx4HPzPribC/M5DyNde9vaDwKLSoLzTExOnut8r3dMSfYS4?=
 =?us-ascii?Q?HWoFlKahJkKxgpvteMxmund+dnUAjBOqkoNRgXfLcrhqMEzMIq0/oEJ5LqCy?=
 =?us-ascii?Q?/taN2G46EdhI0sg4B4gqvVHlzicrV48yjkMfnIhPm7j50OJlGDZOFMsowGdA?=
 =?us-ascii?Q?3xrZxaR3mB8Xp2zqSSB6f05QtfbH2tJ75vkmInLO06F0juRTghDWlTXGLjgE?=
 =?us-ascii?Q?KJvfGV240qtJwDEcnhZlve30oFXdzBbR/AA3MIf8H0tfKXxDl9cHR8R+meW+?=
 =?us-ascii?Q?cKfUY77bFem/v0VAbhWg3BexCVrJFJ2Wl7wRkFUelmOuL2sifMSPBK68gUVI?=
 =?us-ascii?Q?8EH8MKsZUfEOJcNYmp/Mbe74augk6/SdPe1Idbt+PxOGZ9Nt4gMsCENHSEcB?=
 =?us-ascii?Q?ttZHBrdEuctKQHW2672CoXft9bfFSdt7BJXhVgykxiauJrmVHvrW4R7zsarg?=
 =?us-ascii?Q?nWyA7fmARXBIkTFjy8OYd3l3oDVZ35fU1iJ1aPO9eyWl81ZkD7QLfpWBuYRW?=
 =?us-ascii?Q?b8TnsTNKvHA2e1Q6Z4DoBpi7ejqRWhNPuMCZiqQTLQNB/nBO/Iy0uou6fl7x?=
 =?us-ascii?Q?cVRQYKlkDu4NG2zbLd0PJkMT4M8yIz3tBXL2vq+HvhN7k3KRnrRcPuwspokP?=
 =?us-ascii?Q?pUOX8lx3hHkxGhPmlUrejB8x8OFed7P80JYnesA2Aghv9S6+PcaqYfIyNz2c?=
 =?us-ascii?Q?jgfRlAq07tW4oNXspEArtfgy/68nWIU/SUwKlsc96BUJ3xk768d2tdcpK13I?=
 =?us-ascii?Q?lQBjHkNx1qa9+7GZEp7rAP/ZYhrBSWqDYbl5+pNgKDtbN7a9CWgY8WusKf0L?=
 =?us-ascii?Q?Fq+0mZVLiNNLVNxiIzoQJapjscLhvD1uFwVFOT/l2rbo4vrWXO8WzS5ZoOqo?=
 =?us-ascii?Q?gQsKvK543W/XnM7NCk4i2sfgVyVq+znCzJhcSM+vogioAn764lrxZEar4uDT?=
 =?us-ascii?Q?9Qcw03EVbChoCPGNFCagKCoaHqwW/Lk1/UlmCzNbfR9GVTbEJY4UWw+LyAUj?=
 =?us-ascii?Q?VlSUSR0cEXttvmkVwhyGgm0cvJVrCnIdcEtXP8PVgt1RQpf2SNv6W/aiWSNc?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e9acd1-132a-4df5-ea65-08de100f1fdd
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:30:28.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nhf0uvg6FeYaaZ4cyGbt39pXzPslymNjVAbKrDuHheX7iOnQe4afy9gIYwq1s664FHGZTYLw0nmT1F0fz/TZDM2l+i4kFg/r2FZ0EllYgnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com

On Mon, Oct 20, 2025 at 10:19:09AM -0400, Gregory Price wrote:
> On Mon, Oct 20, 2025 at 12:09:34AM -0700, Alison Schofield wrote:
> > > This patch updates cxl_test to enable decoders 1 and 2
> > > in the host-bridge 0 port, in a switch uport under hb0,
> > > and the endpoints ports with size zero simulating
> > > committed zero sized decoders.
> > 
> > Decoders 1 & 2 - those are after decoder 0, the autoregion.
> > That's a problem ATM, when we try to teardown the autoregion we
> > get out of order resets. Like I asked in the other patch, if there
> > are rules about where these zero size decoders may appear, that
> > may make the solution here simpler.
> > 
> 
> I think this is going to require a quirk-doc like other deviations.

Really need to hear more about spec here. You mention quirk, but is it
really a quirk or spec defined behavior?

> 
> A committed decoder must have a base address, and with 0-size subsequent
> or previous decoders would also have an address that covers that address
> as well.  This is on top of the ordering issue if the 0-side decoders
> come after a programmable decoder.
> 
> I'm not convinced this even makes sense as a security thing if you can
> reset the bus and re-activate everything (after a graceful teardown).
> 
> Seems easier to just report the decoders as unavailable and then not
> probe them.

Users see a memdev in the topology and want to use it but find no
available endpoint decoder. We'll probably want a mechanism to show why
that is so, hence the suggestion to add to topology and show as locked.

> 
> ~Gregory
