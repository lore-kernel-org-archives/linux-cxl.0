Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313027A93F;
	Tue,  1 Jul 2025 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381822; cv=fail; b=Ademq4kkEWLjUTxPaDPuANowbvbG8FSNwuiA/rdpAlDzdbzyLPE9kXROX6MyIG14lXDm9l8p6wEyDpEZKq9Xk4QVUZLLYBiqeYV5O3GVm9De3b55DIA/Z86swKsK27TtcYAB7jB+K6yU+Ok5MmQfPRQNCyZ0+65gskTuG8gs6Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381822; c=relaxed/simple;
	bh=/fjmK4Y0WMHRw3jbt5r+4LXb1/tYhcEeZxVdUo6bjyQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GS5gwsotfcb6GOe/wmeVHuAPRcOFK5mrvrSl1WIz56S+Pw9AHvTwxe2u8TmNHHj5ptxL3PWlcmcRNDOc0nu09G+gwVY/BtvZshZ1wYeiwZxp+sgWgOZdMmEabulZciyJ64yM8ZtPJGWlZOXofdaOzXv075iT+ZrM2Y2iCHPYzJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SakWcPvW; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SakWcPvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751381820; x=1782917820;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/fjmK4Y0WMHRw3jbt5r+4LXb1/tYhcEeZxVdUo6bjyQ=;
  b=SakWcPvWQYkyf8txbclvF9JsormJBINQri2uyFPixEXiaeEXSy5gvQDJ
   USupk2vA7XlyIknCEiGLBowp2kfcBsSgcH635WQJRmBJJ+lgZZSdzSuqO
   lBkMpERU26EQMi10qVLZdT2XUO38lzXguNJ/vC4wvJJHQDUNHMKFawgeZ
   yM8+BrunzJ+R7gUh9a891CcTORRrlxMziH9BUwV01Nge1301rsoZUu7+9
   8dr/QXr0bF+AcROgPt1rwnFwce18XqdiXJikObetpiBY9xn/MKun8zXgm
   XKk/PUd25Du1rmA1NLh4eJhppOxIYTRfzB7VGVkKZxKlUqH8MlukQF3Zr
   w==;
X-CSE-ConnectionGUID: 7WGiPR3RSze9OLwrbEWDbw==
X-CSE-MsgGUID: B1n0Fo1gTQuQ4Glluf+5fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71213296"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71213296"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 07:56:55 -0700
X-CSE-ConnectionGUID: 2JsWliBhT4GGXIXiN4Kg4w==
X-CSE-MsgGUID: f9KptrYCSYmnaIv96tKD6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="154104984"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 07:56:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 07:56:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 07:56:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 07:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcnobcN1VF27FlNBd9tGSZ3iHppNZGXJvHKsD1BcUu7Wx7fubEUtUu5enTbQBkzdarzJfUbQcXxCcoKx0rZNwWnDNUp6QGPaY9WpcM6cs3Kvy2+IButqe79pO7CNGVS0G80Us6m8z+wmrZcYt9lCbY4K50YeWdaiconfFaUKnsRn05j1PWm4fIlqNsz7RW69SySGPgCAHUtXWCLGuaDlhHSpX+Y+hzG4S2d9kZ23w8lAKT37HoF7sfg1t+2YAQ7vHavjzspqao1OOTf5dGnMOYGnEUUKy7reMJgE+n0a/nJmEosXrT/bjS7aXxlv063DVtw6Yb4esAN+jF3q/h1DoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qkpq3UDsOXHvcHQQJei5jFb7Mw7OfgVIeHtIGmzZqc=;
 b=AMzjPVQ/HRVzB+TSX9MQsnCm70d8beaQYjse0SBa1xUTkFh/xx0cpYkrwL/8dyPNLWyfXixXyCyYPyNciBAJLH8V5V3zYJHeJbnUJwiswGYRPjXlcVXKHZfTerguUrRwGMgRNcqK+kCdn7pzJSsezPGbE5f8dfsdEMP7FOoC5jsqjUqkEXMx+HPEjkcl6ILkMdtvOvAcc1dCni4lrAWshB1vyz9LAPwhlLpm54BgHmJI8KVVAzkIX5HDeG1y/yQLLCSNWvzOGrVPAL8yjWm1lfVg13lN195NuIP4CfTDamURGg0uTMQ1WlI+WE09hlLOZeoekoBNPrpHvTx4ZavNJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA2PR11MB4873.namprd11.prod.outlook.com
 (2603:10b6:806:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 1 Jul
 2025 14:56:34 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Tue, 1 Jul 2025
 14:56:34 +0000
Date: Tue, 1 Jul 2025 09:58:01 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl: make cxl_bus_type constant
Message-ID: <6863f77960ce5_2ff1fe294bc@iweiny-mobl.notmuch>
References: <2025070138-vigorous-negative-eae7@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2025070138-vigorous-negative-eae7@gregkh>
X-ClientProxiedBy: MW3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:303:2b::13) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA2PR11MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3573a2-5dc6-4b0a-1109-08ddb8af78f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3xgrfinpn08s0FfrSswdvhES8NwsLHADmioECmI53Nn12v2RmoKUPJC745Yp?=
 =?us-ascii?Q?38WJwjedCMNIsWvGxOzHbCqGgTqIrk7Fb0mwNws/Qrw1LKHWWRp3Uck8WtrC?=
 =?us-ascii?Q?cgEj3ZVENU2LqpI/lWCPm3f8nQpLI4Q2VvrEYWRZ6Jq9ECHMkKJE3iGW124t?=
 =?us-ascii?Q?IPb1duZ7jglK2Co+OqzLfnUqY4Hbgm+ovReySbvr/THfYR2oYvRO23QIpyF6?=
 =?us-ascii?Q?dXb9k62jHSlVwPRWb3GgXsjgPycrl8FUyIzU95aJCM2dogU94+C9ApX34wGU?=
 =?us-ascii?Q?MNMVdGoCnQcxO8Uvn50j/bdf1SJk1rmqytW/Zickgf+CyaT2lSVFVgHV7Q0L?=
 =?us-ascii?Q?JRRsockmPyB9FN5bJmtksyWbu7oRUBxfpwwUN4fB1jQK8X3oNI62yndGRKK8?=
 =?us-ascii?Q?lbFDpF/Gf/lZRFRnqVB65yJtycD9/KheELLuN6+CKaan0AI6LVVuh9q06Axk?=
 =?us-ascii?Q?r+7b8XGv1SpkPsJSSIivuSPmb/OXptqjwCI7NcinOiBlNENFzrYo+hDyW+s+?=
 =?us-ascii?Q?OslXc04XS8zHZOqliULk1RCdXSjX5gwST4B6+hGRx3Bvv9+cYZ5csAIGKbyg?=
 =?us-ascii?Q?7N12GTdQTy0nvPNhEkwGTqunfqclKqFpL5csnq/9CBzXqWAgiqWsOmsfzNoT?=
 =?us-ascii?Q?iQ0TuB3giCDmjBG45gP2V4wqvNjO1KkXceYkQk9XVMSAoNwWS6JkaP2hveGU?=
 =?us-ascii?Q?nwrXqJM0p+jpPIpal0p+qhpuxaqEybNotskM7qBrpj0ppaQ/cx/xb3rq9w3C?=
 =?us-ascii?Q?uZibUfJGwXfmd78toxjaBJMFvANBfjrV8BHwiFDiMPnEoNxtJ5QTp9zjINMn?=
 =?us-ascii?Q?blReuuHd2EA5rxm78u7OHxZtAhP4eBqVJpB8BE+qhR3814W18k5bMYHYhihh?=
 =?us-ascii?Q?NHzgBhRf7PiZhBq+DBFSg7WHvCKmeNCjNfr4hLym+umBA+RRMI5FZZRPw1UE?=
 =?us-ascii?Q?5ncElR7lLlnkeejqw1hhS58mi0MC7Lmb1kim3oRk255CAN0EOvEGkrg0ba2C?=
 =?us-ascii?Q?ql1U6FdPO00k03O/RncHEaU/sU9DW/nAPfCBrMseWhhJ4SKJDzd3+8IIIIaq?=
 =?us-ascii?Q?2shRga3iez5GqImjZDpvg8Ria+t0lPTjs0s2pTMhzbWfI0nw5lqpPkOlMxCh?=
 =?us-ascii?Q?4m0Fc0//hPE9r8mi4nfbVwVN6dAYN7QMcluCkJq7C6YPRPGjRRq/+zigvaz0?=
 =?us-ascii?Q?JJulklUTOsno7n1uhTgMWEqym8FG6fn97gcCu5Hr1jvtCUAnT8Oyw/UenLSn?=
 =?us-ascii?Q?FOWMlJCLLGy/JYp3UvaqS/UjE5dwK+Jq2VlfkhEYfHNh7imrdSz694B+7J5L?=
 =?us-ascii?Q?qK8tQUMjFdaDRlZSXDfyQEYs5b7IYLMVXkpOgL5ylM5bvezTkzJUgDrvuDyl?=
 =?us-ascii?Q?VOrf70pY4veQJ9VnS40bqvQ+v8rZDiVLbjyex1xd9GI1aAhpj1QJpwhUrHGQ?=
 =?us-ascii?Q?/mE/zMM30aI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VNHz0I8fk8W/9wdVcu0UHrRIR1IoTfjZm7rJfEE5c32rAsihVKN64rifQpOc?=
 =?us-ascii?Q?VNSlY2Gm4KlXUA8+NgiP+6+oyjFwoeST9UWBUUiOqOrROb2I7W+TEg5oWkyJ?=
 =?us-ascii?Q?asz7kRijKWA3S0D/4r/5ngJ8HVsvv0koh7DBxxfYwxNEgfeA44YhXuUBzngI?=
 =?us-ascii?Q?mXqFpCC4CKfd1nMn3xGaTPJFXFImd9XZeN1LLja4yx8KaYgbMNKoYpGyTrOs?=
 =?us-ascii?Q?HiFZxaKVTER3N0JDTVT/wsEmzSM7ft7tkwcUGPC8iRxDSwCDSX+jgLHB9CW3?=
 =?us-ascii?Q?V1Ie4UrklpaPZYV1HnW0HdFm8jp3d7mwcntym/j2LG0zrxltNLW33jxyPqC/?=
 =?us-ascii?Q?FB0TyKxeEHvEBpH1mOApoJF7Pbakslakha099sFzCZH/3yILOpN/WIvMQ6RW?=
 =?us-ascii?Q?cHNog+Nn9ni4sF0j81NQWrxZ8PGkVVsqz3PwZJZjL0A6qx8ysCh407wGfpij?=
 =?us-ascii?Q?IifxSo+Me/p6GsXhW18zacWdOvKhllnyn8XikFD2SAs291pXPVMMkHDIIKF0?=
 =?us-ascii?Q?fzFNT95DnkY10zGeBcAdwyn+Jt4PoQ7HIe0dd1ADm5Ahxgi/b95yOwruoh/B?=
 =?us-ascii?Q?CV4xCnnVHohGLwr5vZYffkMONF9d/hhkBADV63ZC6FI727LyncHdWWMsZLsz?=
 =?us-ascii?Q?Enbnh34UigC1ghuYyWbqTbO2xp+G/EnRQtNFMsjWNouvj4R3Hxi7Yfr3rHX5?=
 =?us-ascii?Q?/PaQDQHPOSg+OwE1qTdYzPnsrvs3JsZM+/jDN3dKbUo7zbOvPALCW7s35hsg?=
 =?us-ascii?Q?aGj5D9ccTRoq6TG6FmIns5ebxKLmyCL7wh9f1/P8h0FJu9jhO14vmvSYgkn/?=
 =?us-ascii?Q?IEAu33WZzI8HQId4BOu3E46fAwdVeOn/XdCfqj8AF20yZS/y8up/GvetGdhZ?=
 =?us-ascii?Q?/ZIkMLDCTYcibmMRAC01ZL6TN6ZPTLzq2os28Hwfy50k0tOmMvkxwSiov2Kz?=
 =?us-ascii?Q?X6pgChB3j5yydfW1/2q5f788G5fh3DvuAkWNBk4IAbVd9vF0Jra09iEFfjWp?=
 =?us-ascii?Q?F5F5MN2i43kDenfY4kj6TQNY68uzgVlC6OFZ2ZxdXIRsH5jtRsIPrpXwdhdG?=
 =?us-ascii?Q?4m0Qi+RzmcrSg6aFdCl1bYQuBkQP5I17bd2+lU+kbIiK+rej1QeyEeiulv8X?=
 =?us-ascii?Q?JOU1Kk9DEh79zUIwE401yvQ+2LPLVKAPGk3k7IYp1dwIV+xhY1G6oq5hdo+k?=
 =?us-ascii?Q?gH8IDQl+c2Z+CNwtXtbIILJkkQt80irw9dmwVBg+KIrY9XWfrXJYg3vkpYUa?=
 =?us-ascii?Q?HSWBvTg0dT+SOPswpgxfKTzO/Rh1Z/yyorLsLNz8amcO8TcPo2a5Qd0yMd3Q?=
 =?us-ascii?Q?gxspbeRcGz7QSBKgxGI56ae2636UCu+GRaWClbzcD4D42FCPiLPXCEG8/6mq?=
 =?us-ascii?Q?cW0g5wNyPAeX8n1AlwQQZkW0CY187ksvDuhRSMHtV2q/YqZkMz8WR0nhkmYU?=
 =?us-ascii?Q?sj/lq7XUwOttocN9jRiHer3a3Qx2eT8MJm/FG8T98xS0NEu2BH+nYAiuN+OU?=
 =?us-ascii?Q?xvhgEswzmd5JQewHYmCv/W1gSUo9upXqgDEffrMmBnIyGGMcSPUpIEXrIhWx?=
 =?us-ascii?Q?83yFQItqerelUtauPrDNy1G5KLDUPvj0cOUyWZ4j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3573a2-5dc6-4b0a-1109-08ddb8af78f7
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:56:34.6265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWpj1+MXNZOYcdyW/SEr4krXDW5vud6Wq/7Ky1NPYin8xTuYyZnCm99PuYGrpCJ1Iefjdp2CHN6at5uimhKYvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com

Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the cxl_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
