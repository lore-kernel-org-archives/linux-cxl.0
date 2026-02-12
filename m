Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F378F2E;
	Thu, 12 Feb 2026 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770860929; cv=fail; b=ehfD6/xtS5JhXXOv4uAI1zh7q1QA+RfW6q31vTw2lbm/gCBJc8cIVljxIbynZozKme7LnEuydwy0YtHaOrHrDbM8Vq3sTHJj87sEuuITYxzSfFcpGb70MM4vcxBj9vzuoeIMJD2a3QNKH5rPKTbFTEfV8rcHUPah6UpcCv0lfjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770860929; c=relaxed/simple;
	bh=G3lbPu+GDOjKQTQi04D93qDOSnWFu0Bl6wmFKiLC/ys=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=pUL9YUs/ypFhmBTV9SXn2dKu/CiW3l5XRljCgsksGNJtHNJ5r2hg7Ox9Y+D5RvYCIcaMmMb9L2yPuOv4gIXSIZGAW9damIB0kBQVJlhlkin80SmmRaO+HgThvBT14P5HtLbzgEUZQQjMgsNO2ye0m7JFmQdn19ZGlOYqObgB+IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhK4IOQt; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhK4IOQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770860927; x=1802396927;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=G3lbPu+GDOjKQTQi04D93qDOSnWFu0Bl6wmFKiLC/ys=;
  b=WhK4IOQtQqL5GsaE9+eQM0GlThcYSVjiYD2+cZKuMtRemDrpV888lykp
   lT96jj9sE6tCxUMvGJ3E/3o1iRvRnNnzc1EAYNAbdZyWqwuwNnPC0bhXv
   VttI9Kkyu3ICoAZHGlh2iqTN/rOmL0Ka/IitCGRRhE3bcE20MKWZD4Dkj
   L1vF+/h0lkg0OzZLg5HHIu/7aU/T4+xG1c4sQIFZ/Y8w8H1gHLrwPiZGJ
   VYg9mmFHtEdwtVoqYphmXxlJZs1LS/SWoP83D3UFpV0lH1Lrn4O6Zgp7t
   nnCcKmevPvIf1vQBfurelcvmU/xFDU2GXuww0lKg8mi1ZnU/tfwGNDeLd
   Q==;
X-CSE-ConnectionGUID: G+16VC+ORBeWGqGXKiMVKQ==
X-CSE-MsgGUID: DcvQlKmqSyuC2TEmPADcgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="82750052"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="82750052"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 17:48:46 -0800
X-CSE-ConnectionGUID: 4rIdReOzSn6QG4UNUNUXxQ==
X-CSE-MsgGUID: cm5GHHlsSBanf3G8HIr3+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="212461149"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 17:48:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 17:48:45 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 17:48:45 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 17:48:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2MMF5e1ff4mMDcm+fCEstop32TZyhvQSkTU6H2lSw7T8bKClYud+8fZWCR//Vb2VwrRkAY+bvU7tAdcdbcHXsN7KcAdHg5Z2IoKwGEsgnSahaat3rdndI3C2xpbQS/Sby9flO3VS64ZisoP4ATCLK7/5y5ehc26D1mLKkoBlJJ2q5abSCspP02PBaOxt2qa6ig9GnNnDd/ofnqz8p88S2QdB9hACj7XL1VcMbT0zlRUO7QDfEE4F0993UPLti9I68dJBo9Rh6m7Ve90fYDheZZlL1To8I2ykp7HkZes+VkFTsk4HeF83+joVKrJM8GFjwHfewJ2ZbTlcGO/XIQgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjdbNQ8RvfQKKb9No08c8FzOmzkwSV7meaPnYEXtM5c=;
 b=H8ibmQyrahU4ubhMGgjP+GQ2Nq693DKNlCtrBCAVe8bs1Gg6BvPC170YQLejun01u/L50zjvyw7eqMkoh43IEIGRY0Lu1Gs8WGeM6ZKY0200NgZ00WQH+q5lX4QY7oI+/o0iO0xns3Vtp0impEhYeZfmFzvtrU/NiK+b6D6xqqa/d54E5bNt85/2atfS3H1aZmEc4OP3hMhEtKG/kIJ5BxHwsCs4y6/0TLR0EnTsBmVYkgr0+hEjqtjzySf7g+cZjmKfRQe4FqjocBX+vsSj3MEEbEBfpaGD3mr/gkGcHtLpwBJ5S6GG7mA7ehJ6temX7j83oOl+BUxRqwy/9TFJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF07B018B9F.namprd11.prod.outlook.com (2603:10b6:f:fc02::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 01:48:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 01:48:40 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 11 Feb 2026 17:48:37 -0800
To: Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Message-ID: <698d3175f3f91_8c3210025@dwillia2-mobl4.notmuch>
In-Reply-To: <20260210-fix-port-enumeration-failure-v3-0-06acce0b9ead@zohomail.com>
References: <20260210-fix-port-enumeration-failure-v3-0-06acce0b9ead@zohomail.com>
Subject: Re: [PATCH v3 0/3] Fix port enumeration failure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF07B018B9F:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c9dd2f-1a9f-4b3d-8b52-08de69d8d831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0ZPTThzNy8xc1RNWVJIZTdCOVRxQnBOQ3gyemRtOVc0WnRBbk5DTUNnVm5s?=
 =?utf-8?B?UVBjUC84ZDlkQVk0ZjQ0TUc4THVqMno2em5FdC9DQ3N0RkpDMUhIbkR4b2JE?=
 =?utf-8?B?KytTZGNTVCtVZjNwODhQcm1zY3YrNTdZS1ZiM0dtS2tBNUJsSVZlTUw0cmlP?=
 =?utf-8?B?K3dTU1kydFhLcWtKSkViZmpjRFV5ZlNHaTRTZStLMDdjTnYrMW9KaXdhdHM5?=
 =?utf-8?B?azk2VmJ5OEdDa2IzZXNXbDdSY1RPMkEvNXhDVi9xVFhaYktVWjI3WlkzMkxn?=
 =?utf-8?B?bW5ibVE5TzlDb2I5YjMvdUJNZ1JXNEhXR1Yxa3hMY0lCYjhlUk5vVjhwd1NU?=
 =?utf-8?B?ZTJha2E1bEt2Vkg3K2p3NEhYL3lWekdHOVBFemJlOVdVNkYyeFNGbTlRZHg1?=
 =?utf-8?B?OHdUcytHRG5peVBwWUUzalpPUVlyUVZHZGd6YzBOOEppRjJsdzRveFJyelF2?=
 =?utf-8?B?cWxCNTg2bVUrSEFRUmRiUVpvblJnNjU4bkVmaEx2RzRrSkMyMnByTndZWHZh?=
 =?utf-8?B?bnpHemlGeFJVNDlaOFhVVk1PQ0ExeVVTRGZjRVF2RUhLdkdCQTBhS1l4Mk16?=
 =?utf-8?B?T2Q5RFNsWm1pWDJqNUhWYW9WVmluc1BRcUh0TDZwcmZOK1hXbWU3NHZrTGk3?=
 =?utf-8?B?V2dvS1phejZOMzZyMUJWZlFMc2IzeS95WWlFNEsvTUMyVFJjU1BBUi96MUt5?=
 =?utf-8?B?VnFReVJ2eGZmWjkzalh0cGN2UUpRTzR2NUJzR1FVMGhMb0pDU3R2QUVWUDM2?=
 =?utf-8?B?NlMxMkVRbDZFUzJzODMvZlorUnNlMy9JSXdZU21qSUI2SUtYOGdMR2g3SHVP?=
 =?utf-8?B?OE1nL0krVEdDaFMwMmliTmk0TzJJSHZKbHFaNzFoeEY5U281T0xhMUxqTEM5?=
 =?utf-8?B?MDByNmk2Tmt4MUF4L3BuZ05HZmN6OEQwVWlHQVRWMWZFMEo3WENyK1A5YWNv?=
 =?utf-8?B?NVRZdmdQamorVVdBUHVhY0RUVW1KWWxRTGdkN1lyT0F3QVZ1NWN6cGRvYUta?=
 =?utf-8?B?MG1KbitubDBaU0R2eUJFcm9qNkkybm1kNTIyN0lrOCtVMHF3Z1gvQWVocmpw?=
 =?utf-8?B?ZklaNlR3dlk4dnBmNFF1RW1NRjBDNEdHaDk5YUxTdW52Tzdod3NDNnBEOFdn?=
 =?utf-8?B?RXBoeUgzYUNZS3pxcmF1b2xYWDdBcTU2L2dKNDFOUi9hRUd1di8weXl6bzZ5?=
 =?utf-8?B?OU5WRGs3N0tQR1Y4ZzFGZzhEQmtSMlF1dlFGbHk1QThTN210dmwweEllMGpK?=
 =?utf-8?B?Slk3NzFvT0RLYzFvL28zNEZ2SFEwR2NwUCtyQlc5eU1CQ2VwSHZqa2VYTXdw?=
 =?utf-8?B?cUl2dW5keHVzMHpiWnlnaHA0bVhPbzIwOUtlK0RmMXdyTm1PY3J6eUMwaDJS?=
 =?utf-8?B?OGVIY2NNMFBHYzdiVnRoRW0zVDJ3K3RkaXh0MStsMFl3aXBXc21xamVkVHFP?=
 =?utf-8?B?Q1FaTTVJbTVucGJhZVQwbUZoWVFCKzJaNG5nSitJODhiNDZaYlJ1cXNWSDBV?=
 =?utf-8?B?ZU5wUVhBL1pZMEcrWXJRMnFsQnVrYlo2SFc4UnV1M1p5TU02UkcrSDY4alpW?=
 =?utf-8?B?MkxZVFJwQ3krZUpOTkU0VzVnamN3b1NRcVRWTjFKc285WmhtMG5CZHBsVERJ?=
 =?utf-8?B?OFM2QjJIM25wajZHNE9LZEVzSlVKL1FXYWptTzhuU2dScS9mUUxLeTdlY2VK?=
 =?utf-8?B?VlN2d1h4Q25oRHo0ZThjM2NnUHdVaWhZb3k2b3ArWjNNQzVsdmZDd0dEbVQz?=
 =?utf-8?B?QWlaekZHRjBnVEp3ZTIyNmlQS3ErcElVMGRqbUpYTWk5K2lOdHBoWTA3RmRZ?=
 =?utf-8?B?cFp0RDBnRjJzY3BSNUs0Yks2V3FoZS8wTXNQRVpvTzJka3JYNnZMdy92Z0xo?=
 =?utf-8?B?TG1lNWZ6Vndxd24vK2J4MGRnWWVxRS9UOW56R0lPZjVFdVlKMVpQZDZVeE5S?=
 =?utf-8?B?SGtXSTJaYmFSTE91LzJ2cmlrQWpPUWNIREMyT21TVnE5MjJJaVp2WmNoS0Rp?=
 =?utf-8?B?MDdoMjNKWkowUzRvSWtuYjhsS0hOalZ4cWVkOEZvQ1FaRkNqMDZVaXlya1J5?=
 =?utf-8?B?SG9nQVJDcDZpV1JXVkIzbDN5WWlGOStGdXpONGxxSndZOVpoNzlQZndjenBK?=
 =?utf-8?Q?+tUc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0JBSVc3WDBJSUtZcGdDa1J0cFVoYmRuaXFrSFh5dE9pVHFQTzExVXllZjlP?=
 =?utf-8?B?TFlEWU1qclVQbFhkVXNJbW5NcHYzN0lzeFprZ0xBVmV5ODhKNEZHK2dzQlZN?=
 =?utf-8?B?cVkra1VMMUdDYXBaS2p5RXBaRTRlbjcrMk9RRWVDZkNBMnFTa0h2MUN6N3B5?=
 =?utf-8?B?M0dtZStjTURwOG1UQnFTKy9vWlgzTFcweDErUGFpaXV6clJJRlRwZEtVSWN6?=
 =?utf-8?B?ZHhJNU9MTU8zMWgwU01EajJGOWMxM2VwOGloazloanFmelNlUUdyNS9MaEsv?=
 =?utf-8?B?YzhzTXJJRTBLVFJWcDE2TTFCT2hrNkNLMEd0NXBJQWNGaE5tTkZva3Mzczhh?=
 =?utf-8?B?dU1lZ1I4eUdxMWpIc0VGVFJhTHBGZkFsS2grS2tEc1dHWHFKVTRJRG1mYW4z?=
 =?utf-8?B?ZklhOFB3Mkl4Uy9DNG5oNnFEbnRkRHk2NEcvUFFpOWUyaHR6dVMzdTFTd2lh?=
 =?utf-8?B?cGxTb2NHS0UwMkFKSk40dXJDcUhRcTloSEpRWFpuMUoyUTZsNTBDWWc0MHRH?=
 =?utf-8?B?NXBJWktrVHlyMnhaazA5Zy8yRllucnREV205aUdRdUM5NHd4NU9laU5aRnY4?=
 =?utf-8?B?d2pOU1FRTkVOWjZDSmJSQTNHQ0Eva0xxY2p6a1FYY2RPaHdaWTBPeUZUK1dk?=
 =?utf-8?B?Z0RSaVVzLzFXTW1lclBoQkc0Ti9nSkFFRW1WMVV6Z0xPLzgycUVoN2luREpW?=
 =?utf-8?B?OENjOXZDaWthRjg5MHgxL3pXM0FtcVNKemtyWkRzV3BtTnpVb2FvL1h6bXpM?=
 =?utf-8?B?bERQeXl2WmVHejB4WUpaOGh3YlZmRFBaNk1zNDV0S05aLzUrK0lRVEZLcjFB?=
 =?utf-8?B?M2hRYmIvZGJPeE1RcWdzQk92bEVLWTJaNnc3eElQRW9Jd3BxSGpSNDBHOWpt?=
 =?utf-8?B?TE5ZTjlXdlJROXB2dmhxNXVSczRmYmtVNkY5dkR6UTl4dVJ4TFgyTm02TVBs?=
 =?utf-8?B?aEhUaFJhcW1XQzM0Ti9UakpUaXdJdk5CeFBXYUZMZGlIaHdzTDdrUkMzZlRr?=
 =?utf-8?B?WU1VeTlqS2hUU0taWmN5cmxTQ3Z6MklzNnNrU0RqWVdKNkNvaXNpa2VOQ2Jj?=
 =?utf-8?B?YWZ4dUJHcHNFY1F2T0dPclhMdW9ZbTk0UVJUY2g0UktMU1l6L3JpZHgwTEgx?=
 =?utf-8?B?cVVkQzd1Zmp6cmZDSENGNTZSWUdxUHNHWVNSdXpDaFBPT0t0RjQzdGVKVlFJ?=
 =?utf-8?B?Y2NZeUVKVzUrTDZaQ2I4TXdqd2tGeGNMK0w2dC9vZ3Izb29jVWxWQXJZd2No?=
 =?utf-8?B?OVJvb3ZEd3FleU90TGxaT3ZxS0twVTRibFgyUVM3eURZZDZlcWZ5RjN4c08y?=
 =?utf-8?B?SmZrRVVLMmlLdzBMUGtuVWJFVTFrbk9pLzZ5Nld6ZWhxOUxxcXpZL3VNSE5L?=
 =?utf-8?B?ZG1WUTFkdk5NT1hOcFBzYWI0VWpHcXNYdEtzcjlVMmlsVnN3NERKcFpXc0FQ?=
 =?utf-8?B?cCtGcDBPWkY1aGh5OFBjNWJnMElrTjhNSy8xQ3RlQmk3dHQ5YW16TmIyNUxl?=
 =?utf-8?B?U2FrTnlDRTdocG1OZHJuOWNnNXJodnRxSzhHRnpWRThMK05kTXZ6dzVHWjhB?=
 =?utf-8?B?MG4xUFBhc0Z2aElXRStDSGpzQzlFK0w5ZERSMWsyYUdSVlU1TEQvTG1sWll5?=
 =?utf-8?B?UDBjNWFNZDAvWmYvN0FTWHZDWkZ5eDFDdmJNYVFDR05tZUxQVHZZVFlDeDQz?=
 =?utf-8?B?cE92U2I3VGxnTHJlaW92N2VQb2I4eFZTZ1c5RWc4ck02NkxDUnorMVdVSFVj?=
 =?utf-8?B?YkFEK2ZVY1p5ZHdOLzhMeU1oZTg5UlFhL3ZPbFByUlVyNWVPdWlBMm9QYXNX?=
 =?utf-8?B?ZFBGRG9KbGZNeDJpdjVWWWJyYXdXck5pNVNieEx0c3RCY2U2RkFzQVBLeTZB?=
 =?utf-8?B?WVlPcEFKRzhPSGlpeWNFamhlWXUwS09HTE5PMGNpZGtJcUZpZzJIRlBjaTZI?=
 =?utf-8?B?WUIxV3RYWW9xaUIwRDFNV0J0eTZhaUJzUDR5OFB1eEhteG1XaVZUcnVDd2h5?=
 =?utf-8?B?Tm5nQ0tUWmUzaENZeDhtcHl6Z2RldGRQblFXRmpvUmVocW91RmFFMEwwN3dl?=
 =?utf-8?B?aWsxM2ZydE50SXBlNDRrZ3RIN3dNMmh5d2R6QUxpRzZrZkUwTHBMNGM2ZUw5?=
 =?utf-8?B?YWFNNTFINTRWR3ZDa01PZGd6RGlNcUhJdW9CUUlQZzU4QTFkMyt2STVUVUU5?=
 =?utf-8?B?akJFVEF5ZXdtbUNtU2NNRUhLbWhGQ2NQbG5DTVF1S2E0K2NQLzdSSGRPUjJF?=
 =?utf-8?B?ODNCdVJRaTJMWlA2ZHZUUnd6Nzd5OVp2WXhxNENVTkM4V2xiK29kM1prS1hr?=
 =?utf-8?B?RzdKcGtpdnVFVFRIVEJQK2MyU21jbDVDMFROdkpzMFExbis0R3pPbkxSeTQv?=
 =?utf-8?Q?t1TjtR94W2xHfBxQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c9dd2f-1a9f-4b3d-8b52-08de69d8d831
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 01:48:39.8953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2K4EStwTq0G6FPn4tRsC48im6odUxehsewxKN0ODgoz12eydhP28eP+l6dsp0Ggf1PgKvWVmkuuc5l15NXM/X7k4s7fQWZofxpg5JRQWro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF07B018B9F
X-OriginatorOrg: intel.com

Li Ming wrote:
> I ran CXL mock testing with next branch, I usually hit the following
> call trace.
[..]
> Changes from V2:
> - Split to_port_host() implementation to a lead-in patch. (Dan)
> - Use to_port_host() instead of open coded. (Dan)
> - Rename to_port_host() to port_to_host() to align with dport_to_host().
> 
> Changes from V1:
> - Remove the patch of initializing memdev->endpoint to NULL. (Dan)
> - Fixes typo errors. (Jonathan)
> - Introduce a helper called to_port_host().
> - unregister_port() cleanup.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> Li Ming (3):
>       cxl/port: Introduce port_to_host() helper
>       cxl/port: Hold port host lock during dport adding.
>       cxl/port: Use port_to_host() to get port host
> 
>  drivers/cxl/core/core.h | 18 +++++++++++++++++
>  drivers/cxl/core/port.c | 52 +++++++++++++++++--------------------------------
>  2 files changed, 36 insertions(+), 34 deletions(-)
> ---
> base-commit: 63fbf275fa9f18f7020fb8acf54fa107e51d0f23
> change-id: 20260208-fix-port-enumeration-failure-34e1f4953f02

For the series:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...but I was expecting patch1 and patch3 to be squashed. Dave can do
that on applying, or leave it as is.
