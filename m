Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F123E23D;
	Fri,  7 Mar 2025 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380687; cv=fail; b=LVdkk2pHxtzjDFfj00ZXR6NjIm2sQ5nb4zaV0ESftGgBesg9eiktQtlJHHrcYNGiEI/VhNi+4EKHcb7Mte6TW13mk8qOmhyhPRhH85cU3E7BZfJBbX4ZXtJzzEQuKL+s5aNeOPkbXM/PxDX6EX/Df77JX5aey7s57DnQ81+Au/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380687; c=relaxed/simple;
	bh=qzEkr/2U55Szkieo0VGniBYArv30j6XGtvHnUSUZALs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZrlKNNuLTWDg6fafVrLEmAQDp+TgOQ9UMVWDNZT3jk+Ph0DKIeGRWoX0De/Q5wfMB8suqDnW6HPrp58qmeGfnWN7ioICSpyFIkHhiUNZrunAWmI41cIgngU6kXvEudPL1gKg8dHQSbWmwOPXn/9tHwbNH2C3BJt56lcs7nph48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rh3UZ6bT; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rh3UZ6bT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741380686; x=1772916686;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qzEkr/2U55Szkieo0VGniBYArv30j6XGtvHnUSUZALs=;
  b=Rh3UZ6bT5s299ZFoUVO74cflZpNA7tSlzt7ZN3tsSJV4CTS3blKVzCwH
   iyygAbKZiB9wmwkCoqfyUasyYvcKflNxcYmxvabC20rAgVgZAEiBQAfxO
   CPJOI9jYU9BuqdLFGl4XbICB5vvDZ1jdKz+L9OJIPC/SuppxyFVtMi/mY
   Z7GMz9K4bZXcCVEd4IwG/MLRv0tf5qI/RiBsCBGHko/JEskj4COHYLbwn
   bB9QhBsKQbbtBg+5dIatxHAn57g3Lo1tZIv+Exw6j6DKQdTJ3OuWdKvGJ
   b/7MepmSk22JqoxTjjw8IOpuwL58Sny7AgApR0FQZnG9fjPS3ioPiw96O
   g==;
X-CSE-ConnectionGUID: 8QDykj/ZRmGMVhrnMaGChw==
X-CSE-MsgGUID: VuMxxKeaSv6Dw1R5kPtHEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42642558"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42642558"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:51:25 -0800
X-CSE-ConnectionGUID: BeJ0Lsb+QYCKitUhS1c4xg==
X-CSE-MsgGUID: IhasdJ4oQNygz8QoOxIlGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119249348"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:51:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 12:51:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 12:51:24 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 12:51:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDnaxQgNKE5E3j2ImKTCtk75uhw3R7bL3flGh1kN28ppFyzKgpOuOAiaUYhLvFuuO3bx0NU/ktgtmf08BAs5I/AWRm5P2NzZmWc1+wUGr69IjIwl79ULaxzdjwZP9UNbwVXlHNC+qS0+IFNAMf91uhoCxaQLbVxhbImFr4Iqhm4Tgwfo1TY/IEMuaWA56rpOwfVsHcfAwr5+zVP8to6ijBvo4Hkc3fO8hP2nY4RyTryWjOR6T+E1YbrBWGTwEgNRL6JbHtGl4SPSJrzhdLq7PWRatQC6mTlQLXUBOBpidFe2B9m0fePAEg5wiGXaJsTwcI2eKnU3wcuvkH1dejZr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfqOqznBPpB8RQyxawlY0Lrbcf76pLwz7EkBetGSZoI=;
 b=dgtO49GnolZP9fW7bWS3X3zQ3ZL2Olf7uUbiM/EVk9zZZXod9OHjhNmRx3OFXW0EL5E8YNYS4C6vm9/UBcBYk20cJyDdJ+pRA/TY76Pttj/qkJzS5x7k2kFrKV8bb/lBHrDFuVZJAs6DuZQb4HGRYaxuFwYUyrqPn2kjzPHvMW8ix67U0q+y4cB8CxkAMzxUipTbHNQBMcjx87EBLsC86BkznrwNqD+VWkoOkKDiBf/xC9eY1nnY8MdyTCWZGlGEQJrlkigk3VC3XHMFqm11XtXSDkhtduSPcjGxbYXvw5gzDBfwDQihKNAJzq9nkLVfJEjZsFlbtNNv9q12IxRWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19)
 by CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Fri, 7 Mar
 2025 20:51:21 +0000
Received: from MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24]) by MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:51:21 +0000
Date: Fri, 7 Mar 2025 14:51:31 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Robert Richter <rrichter@amd.com>, Ira Weiny <ira.weiny@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Terry Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH 2/2] cxl/pci: Check link status and only enable active
 dports
Message-ID: <67cb5c53405df_17b58e294bf@iweiny-mobl.notmuch>
References: <20250305100123.3077031-1-rrichter@amd.com>
 <20250305100123.3077031-3-rrichter@amd.com>
 <67c86b9f770e8_77ff4294ed@iweiny-mobl.notmuch>
 <Z8sUDKcQ22oBgUh5@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z8sUDKcQ22oBgUh5@rric.localdomain>
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6739:EE_|CO1PR11MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c28232f-09c3-41c8-21a7-08dd5db9d0f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XYmHEZ2RN2vNVe0vDxOT3NmW0A83XimbCS/UQ+9jBxYQPJgAXiHyL/aX/KVd?=
 =?us-ascii?Q?yV6iEj2Fyr/GuQaOzZRe8VBDFinb5Q6t9lTxw3qBTsFHk/nw5yYTahAwwIih?=
 =?us-ascii?Q?tQ2SQ2AjCM9PVHfuNZi6pCp/snpPjZSdnI2iSvqYthVwQLaYxvCJUoeKkZ/Z?=
 =?us-ascii?Q?G93LoUOthLx+YMe7fI1jmCNqSQP6bmMuB8XPSj2eTn6QSbUTKUiA9pwgFBKG?=
 =?us-ascii?Q?/hDuRbyUewgLY6M1EJQCh6Kfaon9ampCjiB/tsIhlDyaq+xo+e2efT+Rgh0n?=
 =?us-ascii?Q?WKfpXfDXNXhbIjbXidbpoMC1qvB0u10G9QvxYZhLlAUHQZtOHoMi0EK+x2Af?=
 =?us-ascii?Q?ZFECXmgOiEGDVt+v+MmS4ela8P0BA97neOX2t3nT/HVS1uP/nb0ljYz8XSmJ?=
 =?us-ascii?Q?A0T40dD0xlf/oxaE7U9nuLwB1HIPLV75uKyrqArOsRHegrpdx9Mp4zSl0vyH?=
 =?us-ascii?Q?Xu5QxdCmEg+sssPpmrefXoMLPOJQwWES3Qm8hsXbLPPsqtB5cF0xO3CPJylH?=
 =?us-ascii?Q?7OapdS0/Dh5x3XFbpHunDhkaiUObukGhDk846Sc6xfiA/XGc3WjfIeLKyyj/?=
 =?us-ascii?Q?ojwEnTbIA+dDiWP1bHbHhcqnAvy66rBL143IADuIEHiMjkHaxjJqpUcxpFqp?=
 =?us-ascii?Q?2g3mload62vN9eO44c2LpZK5jAA4WN3WHnppX0SjJWJMqz3S8rGfafsjSUW8?=
 =?us-ascii?Q?W8KGUf0yYzNCSxH0JbtU5t5X7mip1xbSRFYcJiKz6q6cu3GKtpZrO4gKCS95?=
 =?us-ascii?Q?p0WIpEdS5PGiAG88/4I8FREyz33ysEmEy68eymnY/1N8o+gueIYReAhRLl6b?=
 =?us-ascii?Q?ziv3IQYZdy6H4qEHo0c35zvqcowotX4NPpGMcl21NUSkf131p+Xj5G6qLoi1?=
 =?us-ascii?Q?qDHXmVkPIDyfOcpMS9n8myAZcxEzI7joL3a2UATB338Rlh9QTPXrzKf2vxKv?=
 =?us-ascii?Q?JWV6oZ/j+IKsGoCiwgEgpmRii0kaCIET6v5W/jnt0AUGMEQvCws34pTqWOsZ?=
 =?us-ascii?Q?CqHftjCin5H53j5+xXb8640sN6QvhNmcI9i2RqrX3n6phv0dQm9jXYW2TR99?=
 =?us-ascii?Q?IWoKSROk3JE2SI54rHwL94RpIRGcBZ0XfYgC9eLgGJ/oROrJ7CrITQ7mT4AU?=
 =?us-ascii?Q?vlb0TzDx8nhR4oYzEopnaZY4x39ysugvLY9/T7QK+S42Fi+6MbcAXF1sUs83?=
 =?us-ascii?Q?IIvScaqW151MeP8bRMg5jGq2JpbNUL2Pa1T2AuHYRd5req/YGS9jwjpNOxr0?=
 =?us-ascii?Q?DqQkv7eFES4b2LnL7M/4Y/2SbefCSfNSKwCHuCcnkW0idbBZ72RxYDWFjsxm?=
 =?us-ascii?Q?i+NCnL4/YUQPx2kNaYeXl0zpYJ25Wca8p1ocDV2ppPttnX1um3gtBgBiYpeS?=
 =?us-ascii?Q?+3W0cnl4TdFw5PA9gO9088bnDZS+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?anou0jXROP+RBaHoXNZCFVC/VUK4pP3Czpy48nzVRgL/AcZIgYTCyZNGd0iH?=
 =?us-ascii?Q?AYJ9tvX30wqjwMYvgxB+4wiSPjJQCtYObtyrkWFKgsgBKygcQbU/CBN+JNl6?=
 =?us-ascii?Q?wbWAwCFcD5P/bXbVbDB96eJDhpcj6fq4LXApLVgMR2RCpfYOPqXMKq1b4Ioz?=
 =?us-ascii?Q?cAYof0h167kqbCoouP3HTDIMZdWOhSHqIU5ASWbCTeDBFiMs7Cqwf48GmnVr?=
 =?us-ascii?Q?BySycrUbN5EI0JxDZrigXuULdTF25a+2kplsmMHlAkc/iZnjYFgTDXQMEbHW?=
 =?us-ascii?Q?DL9L6tDXp4prdVJdLXiR1xn5Ay4D9opZPpvl6xFbKxpVVQeYzNZruLbLZlLU?=
 =?us-ascii?Q?IzaeoB81Vh9IXOyIVDmFIYmUPsTX5+cgX7DJF+6CAs6JACx/UGOBnUMZ7X6j?=
 =?us-ascii?Q?vGZ3RbkaxYzxdeZea3Q+c/7SCkxGmtUMop+NFQbn7a0tqob1NgYyTls7b8lU?=
 =?us-ascii?Q?ozSgAReccKH7IvKznn44wusRf6sP9OOoUcEGbhGcWRg6izcqwao8As4cBOXV?=
 =?us-ascii?Q?aw3OkJ5Gz+BbvjqL3hDe87JmZYQKt62n7c/wqmsAL6PfSAlKBDVGTW+4UW7g?=
 =?us-ascii?Q?wPMtTqN8PUBPI8RMlZZDwXiA6XJS/AA160do2Yvy3JGw37I5fwsWjeowuepW?=
 =?us-ascii?Q?1/3lVLP5G7o1JE8cBFR7fSrBYQYOIxX3TLCCuYYXZYS4twPj7y61tOltUE7Y?=
 =?us-ascii?Q?sigwkkl6Lfcg0p+oZd6jTulW67gDBMi7mGStuTrCRVJp+5/B9yEL2oaXV2rG?=
 =?us-ascii?Q?2gGnQ2g0t6zoHkSpOBj1jV2aJm5b4uGWgtq38Z4luZktxkhmmuLm8+o9L4Uz?=
 =?us-ascii?Q?whR6z+LxBmwTRxIMmKWTZk7LFM0/Tpi0sBJ8nQGAHMN0hxq7S29rAgIKFEDj?=
 =?us-ascii?Q?gRbA+yuKU7JJLZa14bgqs9XxqYojQo73zTadYQ0PHA+psshzIzK5WpJSTSgA?=
 =?us-ascii?Q?1O68Yhzjix5GM7Urjl7HpZns2nHrhwJoLiS7UJ3HpGvg/YIkx6cO2VeMAnGa?=
 =?us-ascii?Q?MvdPFxTKrwPax+f70Gw4S9tsBW336D607AW59EyTJyjJzkRIUEfK9E/pZBY1?=
 =?us-ascii?Q?NRoXaseqINtV+0Qwm4apF1oM5SgoT1P/UBuBBBAt/VwE9xQuiHba8jDjy13h?=
 =?us-ascii?Q?yaLF/NEfXIWsDMkhdVozKsdz2AKZVkjJmo5z678XXMq3tioL2w5nxGnfJd/U?=
 =?us-ascii?Q?nabDIBCs5xHbrFiQMy0L7fjD17eaPqxNPtSlVf+56v4rEYXRXZqTUCNyNtSh?=
 =?us-ascii?Q?AoWN0zJeGZZ9U2P6GXQNBPrHRKgMfHF7Io2F4dfFxJ58t93TBeoc9hpLWP1P?=
 =?us-ascii?Q?BWYX6nr8vKzxHozdw/s3m8bjp1fBego0Pe+pIK54uUge1HKiGsb1Q9sF5T2v?=
 =?us-ascii?Q?icbA9nu3bhWjmSWqvZDSmn5wMiFBcBDjHpryaToeeeiNqPKJOc5uGcSnmsSH?=
 =?us-ascii?Q?m2tmAQDda5bv1CMj+igqaGE9bmNYQoPrEBohVWBm+KMuYa4+0ZOC8d7fRnLu?=
 =?us-ascii?Q?FMkrpGtwSiGCbVHK/8Xs1CAZ0oA4FGcOtJO5ipwcgEbp1SgwFoX0Q7gWpLIn?=
 =?us-ascii?Q?PmR1NaWa2iMjIGQgQrOjBB7MrWsCm1ckleHoFnfE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c28232f-09c3-41c8-21a7-08dd5db9d0f9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:51:21.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8T+JmU+qwc0CoZUJXzLiviL8uQE27bX/Z+zm2XVkmVskzN6fAINZh3G9fD9+KiVJGqTPv43WTVeEGnlHiess0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5073
X-OriginatorOrg: intel.com

Robert Richter wrote:
> On 05.03.25 09:19:59, Ira Weiny wrote:
> > Robert Richter wrote:
> > > When downstream ports are enumerated, some of them may not be
> > > connected to a corresponding endpoint or upstream switch port. The
> > > dport is inactive and its link status is down then. For permanently
> > > disabled ports a HwInit configuration mechanism (set by hardware or
> > > firmware) may assign a (further unused) default port number. The port
> > > number may be set to the same value accross other inactive links.
> > > Those duplicate port numbers cause the downstream port enumeration to
> > > fail including the root or switch port initialization
> > > (cxl_switch_port_probe()) and all its active downstream ports.
> > > 
> > > Prevent a port initialization failure by checking the link status and
> > > only enabling active dports. If a dport is inactive, there is no
> > > matching component (endpoint or switch) connected to and thus, it must
> > > not be enumerated and added to the kernel's CXL device hierarchy.
> > > There is no device that will connect to an inactive dport.
> > 
> > This makes much more sense.
> > 
> > Wouldn't it be better to use this patch and leave the old error
> > messages/failures on duplicate port ids?  IOW drop patch 1?
> 
> The link check only works if Data Link Layer Link Active Reporting is
> supported. That is why there is the patch 1. That patch also handles
> cases where dups are seen that are unrelated to the link status.

Isn't it a bug in the hardware to have 2 active dports with the same ID?

> 
> > What happens if a link is having issues (perhaps going up and down) and
> > RAS events fire for this dport?  Does the lack of a dport object cause
> > issues?
> 
> Once a dport was enumerated it exists as long as the parent exists.

Yes but do we care enough about this unused memory being held until the
destruction of the device object?

Currently I think it all get's torn down which means we are not keeping
memory around.

Ira
