Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A439475;
	Thu, 30 Jan 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738250151; cv=fail; b=UOSbmZrb5+mkMOQ/0bE6/XJIzIpeukAbZmlYsmR9OD8vNg74A1piwFmzNOdrEpPsikZHvaQGe6tb2yOg2NYyTDiqzG5pjReWwtvKzKbRvKovq+iEchVXekn6ars6XiZLPniMKKj/B7p/QQyXFyMsW5yXbjkt+hrfXzvrIGJjwvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738250151; c=relaxed/simple;
	bh=wx4ZCOirrkFpixaKIvVLTS6s0I9wTyhUuzIDvYX/TJg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dBOwv/QGHAJ2Vr4L4T8dJ0fEp9m37AMsG0aIIoRn7xrm0x7R/IQw8eked444BeGzi+qWK6vJfT5kqzoCt8I5spqe/lA99RelymtkDRQPlrXYG0Q7vk+niMijF+yJ6yPTcYq4UhM5A33n2poWR8wnYU9vcUFHQ3roYxbmkC7xQPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j05RCiGy; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j05RCiGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738250150; x=1769786150;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wx4ZCOirrkFpixaKIvVLTS6s0I9wTyhUuzIDvYX/TJg=;
  b=j05RCiGyI6mMMTQjn8Cr1IMmxoFXxOLhTXtjOoZ5pZq11Ap7JviNdsfv
   cmlkohlKvL7JevEVJm1kwBgipEbpiinlgDr6DobdHwVgbF/TkYBq7JsHA
   V05LoZPY4eivFyEqdzgsigoY/LMbCJyubvcAfvhl//jFeX9nIG+JaKlFL
   8KYgaubflnniUJeSseZUX+V49TRm04uDj6qN6Fx/PvniZX0iPpHYFon9U
   oGwOZdMcbq1jH8cMEBFDXXetKtKDeOEzSssLp8LWRBl2sJNcbqH3CeNI5
   mCxMLghdnA6hmvEaPgJ4xEhZUyI8jh1B3qgd4yZXnJzZejFQumwun4rPI
   w==;
X-CSE-ConnectionGUID: Yf4eF9ApSKGabM3HKlzbkQ==
X-CSE-MsgGUID: oyg0QCOxSjaLqdMx/S4+Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="50183853"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="50183853"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 07:15:49 -0800
X-CSE-ConnectionGUID: 3jcIu3GsTjCdn0lfJXlINQ==
X-CSE-MsgGUID: ulwSW/IaR8G+TeZHqG41+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110260690"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2025 07:15:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 30 Jan 2025 07:15:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 30 Jan 2025 07:15:48 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 30 Jan 2025 07:15:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDoSBHki6pmxtMAu9XUZsdYNo5y1QDAfdu7GV74lHgpBiVGFssNdzWtV01T/BQxoSAzSnLeA5ihEe4oDdK+Een2zp6pwBKOj43sR+OSQnK4uV6K8SXqIwaMTeYupo6pBGf6hTPwzZUgAhxQEXTCBpp0mUX7qTKpqj1Lopc38x+7DXAFQC87uBVswHnB0hWRpZ44Kkmwt4PAr/z1lpJyaT9L0hYRiypT6lJ/tHcSLk5J1OyGyJMA/sZHSicXXIL67G1PWnkS03wcxVLX8v6D3jsR6Zenh/lPJ2eQHINSuOROxEyUlkYyQtE7Nv0oJNGSp42OV794q4D3CjxgWGMrNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+NX2mIiBC5wN0cS0Sb6saFUEWE6n4gkAUYZd5VQInA=;
 b=HTkaqkIg6XU0/+UfB+zLPR/1jRL/hsMqUc67Z9WNNnGhZao+6UMw3liAU3+rfLmEQaPRFX+KYqVKeBX+w04mAlUTPzFOQn5bTa+nZr5pUBClO0tg+zWFrCAbfveVRe0qR37f2WKAOSDr0GaJQGTwSQgarsPC3xZ0MyYjkRIviTG9t/+ZqdyWpEePLqX5g1o48YTxiuV8b8q7M92PEMuuZuVubpNs71XayQPeEJX0k/B2GTVILWenz5LL2iYNy6/AYjoBH2TtDMNqI3D2m6UUTysJ91cS3isO38VGbWwWswDPzRPuXTFySGxCO7pplPnJZ06lpNK5d0A/vXc6nJqCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6885.namprd11.prod.outlook.com (2603:10b6:303:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Thu, 30 Jan
 2025 15:15:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 15:15:03 +0000
Date: Thu, 30 Jan 2025 09:14:59 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Message-ID: <679b97732702b_24e5d72945a@iweiny-mobl.notmuch>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
 <20250130135220.00003637@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250130135220.00003637@huawei.com>
X-ClientProxiedBy: MW4PR04CA0250.namprd04.prod.outlook.com
 (2603:10b6:303:88::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1d5358-9bdc-467e-ac9a-08dd4140df24
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UnCwIvsGWc8LNDN/p9uxBWJAN8kyZPOU4Wm3cZOAFtl0rbAQDfu7BV9bOrNn?=
 =?us-ascii?Q?+R8wXp0QjmKTRZEGjz0n85dPOAWZNo6wUklZ51CISKJ9V0QUM30YyqSrCiO3?=
 =?us-ascii?Q?+Rz9RKdPHPVn5DVV3v/i2l7HUR56hT43fmgIMCeiHGVBNBhaKxckg8H3l9Up?=
 =?us-ascii?Q?TkANd04pw8U0W8ZfgitHaauJQ3jOCsDvXk/gsJuhLvUrzmNRLSuVeNUugYho?=
 =?us-ascii?Q?BJ21M0s75A141leHM5rNbt8qsPOsu6RLDy7paMA059CF6ULuTR4ArXydmULT?=
 =?us-ascii?Q?+hWa03vl/DJpvd6jS+t/F9qKF72PSGpq/PckQ28sJbVLBz78Gfex1Ato9pg0?=
 =?us-ascii?Q?Eo60cSUims7SmrOnQlFcVXlZvZehgYJ21P5VKlvo7XVwDUK1CXECEuUG4cii?=
 =?us-ascii?Q?pECZwN3P5I9+qUN4CMF43a4dPssrDDScYTTinfy+ICTQWBidlcpOs/KSYSSb?=
 =?us-ascii?Q?X8NxuBL3p19n8KNDvw09NzRe3D4o569MqwL1shADlhptnGNuExUUu+3f2fUO?=
 =?us-ascii?Q?5ZLIAunMXTekd6o+BqN2BBqNOe/RSgl5Xd97PzPUyxxxUNQr3jblF+Ue1gwR?=
 =?us-ascii?Q?uUrDXrdjy8VcKC+w3B1c2Ge1tqNcYhOVYVftYh9flQsOZGj9TGQVQ3YnFXjb?=
 =?us-ascii?Q?N+PKEtCGCVG2hVhuYh9ZJDfiw5ylVYuhyer95wv3J9aKMONEK/IxRdU0ZeNS?=
 =?us-ascii?Q?Qpzab1PPnzE6RIseEoUQObxf2CoIgKDktqllvgi4iSawgukhnP9udXX3dCjO?=
 =?us-ascii?Q?uSr1P5IZP8jjtIdznh0mu/LwHtDv5lUZQzE7IyVVljQs9ogjcwhcOBs/gHYM?=
 =?us-ascii?Q?KUwKbY8UKvUQ+x6KcBxeI7FBCPQWAUXkOAcFhHlUqFq8kmF+hfnM2ksm8Z5b?=
 =?us-ascii?Q?9XaYFzbHR8eHuR+PAJcSupidT7FBclX7q3+dGivsXXcADJtjjjC4pPTUmpzT?=
 =?us-ascii?Q?lb0ZHBN9W9RmKMY42jtiB9UMb5jEV41dPSqBpudjZslBPY8pXrCVnQB5rNyy?=
 =?us-ascii?Q?1Ps9yzj3e+57Bi2vdo30NcmiFnFcwRkQGbpjKS6Zo/OWAUTYfcB2QQC2N/Hr?=
 =?us-ascii?Q?SurKJccnXauM+Lt0jmPvEy0FWvmLvr8EBV19Ok9gzXGDIBlMyAwlpD0fRVY2?=
 =?us-ascii?Q?+bK6XAch4xm4cfw1yaJjYdZAaG+kb5lgSc265uzNwNfmBCWIdh5unpdbFjzz?=
 =?us-ascii?Q?YzIQR+5MNPpTdxtJQIfLsueYspyCcTAHyW3DItd1HnT6/Ga2PAjeQv17ZLBe?=
 =?us-ascii?Q?q0otqeYqPMXUQIj8K3kOTEKZFIJ1gNtGP57C5AdCQJRD7saJmVYt9QzExv+9?=
 =?us-ascii?Q?+MkLCm5/pwLTQco9/W7c/ZkvSuMZB/PNEp0PMaBIs2Zoaw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+AV8DV3IK9UAZ99G8v2ZimmhdavL6hGhESvqcBd0VfoMTMNvyW3S/ss9zdBV?=
 =?us-ascii?Q?wKSavb3pm4hUP9sAt96JkW/tSsrT/cibBUY9umz0ABDVLNQrdFa8jA5c3SUS?=
 =?us-ascii?Q?3Fcrhb6B4EVf+0aDGXvFA/RSTiFwjJBHv/ih8XukwQbP5p2dXbVogMQNL2ed?=
 =?us-ascii?Q?Bet79ln4JylKTK6T5qQPDl5nA6wNbeCcpPPPS6BJykHknRd/4OmaJC79ayqP?=
 =?us-ascii?Q?PKxdYBU2tpUn5rC64EhYId12HhDvY1Uuip1UodUMIa5YOxWiAa6zDAya7U8v?=
 =?us-ascii?Q?zaZb3V8tyspIaOr1Y5IHAV7XxT/JOxkTbgmv7D86U3S/lF+NWVZhOIQHj9Mr?=
 =?us-ascii?Q?44hoUYoHvUMSTRIYNfGFab+VWvWHZ7C97yxfdaXAD4f6s0n2/4+CJLobhFzP?=
 =?us-ascii?Q?bxOqxkFOjK3+NCsaIAUNIVZMUzHLAAFzEUue0HoPkD3mYpPi98N9btAa6jvz?=
 =?us-ascii?Q?aJzSFR7JM6hJnrkXooPlgzVlSma5xtHUpXA2iKBwVrR8BLdNGB8fV1g7YHTI?=
 =?us-ascii?Q?5Rzy02mIJzgHf8yzjeVMp4dz+G7p/P/DAT3ufqSfvy3fNIlBmRV8CzYPZilM?=
 =?us-ascii?Q?WmW7lnkNXjw7qi+ABOSM96lvaLCYQOfbHzvJDlZyzz0qMdjLOBJYVaicXK6h?=
 =?us-ascii?Q?KhD38yAgFm9J+OPlIOwdlnHeRtpPqK0aoq+3yafdWFN4Wx3+ThV6tlgdCv4M?=
 =?us-ascii?Q?CC04zeQiWXzv0JV/BzEt0XCLK4XrMowvgbIgYOcKDKVa+NTOFpTL9U4OuLfr?=
 =?us-ascii?Q?L1rCMhpje3IXeY8JcoxMS02xAHTfEtAE1/rKBlo4iaW4/zD0byG/wlbx0wHv?=
 =?us-ascii?Q?L7ukb7UN88AIYiBtB+8enpyW0Ju05fakFq+iSVHKB4vp1ItDbIbO4lRifhYj?=
 =?us-ascii?Q?yI89K8mCrk1JSwvJz+c/b2lG0Re/psnxGlFez2zDIPBMSVCKDJxpYioiBTXI?=
 =?us-ascii?Q?ZadvBr39zcacC3OZTO8vvmQkbYqVweYKD3Xuj53vA9ccP+TgJmzZM064td7j?=
 =?us-ascii?Q?c3bBb7sSkavxItJzIPLHU5ch/giejigRXN3t5RHA+yc/0/Jfqs8aSXxwEWOh?=
 =?us-ascii?Q?qjl9M0pLLTq/7hwoLukkHY22sJNTLqxrWGZLGx6wu02ZWcKRIOn2YiDb++YK?=
 =?us-ascii?Q?nXIqkKDC7Y8RZRXs1eDifYppNRnj1ruUx+ZECSTsMO9VdALsd63nmTN7ExmZ?=
 =?us-ascii?Q?hz6NZsr6bukbNuVrICK7vndZMDYwCRSxHwkFHEtQ5qxEe67XtOmrRGUIWgLp?=
 =?us-ascii?Q?OAR0UN/r2FKKjIuUySh/Tuz/Q+4Yga9MRotdqMK0aKhPHIM/eSRunS2Su0Xb?=
 =?us-ascii?Q?VmMfi/tMlArDnony842g4XZUDTBl0Ls057AN2FR/MpDGKV931INa0oa9DEdm?=
 =?us-ascii?Q?fYiazhGYeDIo7iLDyh3d/kZUq4OTp2wPgewtr3kPT3AB5W0w1DXdzyiTXFUF?=
 =?us-ascii?Q?65zzfBnYRyrMLjJlKwChjFd7Sy6hZu3vvWzEfhCLrHaug9nPiuhY/1QnbcGE?=
 =?us-ascii?Q?Q34yI+AOmAWlUv9I+VqHhEdS19iftoXir8G0cevQGzH8OO+DjkIjX0dUK/0E?=
 =?us-ascii?Q?7kmaEhIBUr06HxtnpcvanNvX1CeIHbpwr2KKjX0z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1d5358-9bdc-467e-ac9a-08dd4140df24
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 15:15:03.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JIQB4YKoVPvUtuj8UxfQD5c/WTDV9LDMu7+qSUXNDUOmbAlIX5RhMyQGyo/74isL0I4q9lO0FoV7wHoOvH3hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6885
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 28 Jan 2025 12:51:08 -0600
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > As was mentioned by Dan[1] cxl_memdev_state stores values which are only
> > used during device probe.  This clutters the data structure and is a
> > hindrance on code maintenance.  Those values are best handled with
> > temporary variables.
> > 
> > Adjust the query of memory devices to read byte sizes in one call which
> > takes partition information into account.  Use the values to create
> > partitions for device state initialization.  Take care to separate the
> > mailbox queries from the initialization of device state to steer the
> > mbox code toward taking mailbox objects rather than memdev states.
> > Update spec references while changing these calls.
> Why not jump to 3.2? 

<shrug> Just been in the 3.1 spec for so long I forgot.

> > 
> > Link: https://lore.kernel.org/all/67871f05cd767_20f32947f@dwillia2-xfh.jf.intel.com.notmuch/ [1]
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Not sure why you had this as an RFC!
> Was it just that we are waiting for v3 from Dan?

Yes.  I wanted to get these out there for Alejandro to see the direction
of the dev state call.

> 
> If so maybe Dan, just stick these on the back of your series if you are
> happen with these and make Dave's job a tiny bit easier (and so
> rebases happen without needing to sync the two sets).

That is fine with me if Dan has time.

Ira
