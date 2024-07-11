Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486085956
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720737344; cv=fail; b=QWq6NftfsgeVyFEN6gP5/TzhrxbHeLcbI8qOyNqEqlrI8Ga/LQp+s/COCt7uvF4+xlCSODtDqhi4R4ErElAwMQMcxwQcPtz8UqY9Pu2izTHoSoQegXT4H5ymD2uWnFz94iNl+CebNR6+FRprNdTnjA4INuP1Yy+4IajK8T4ktbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720737344; c=relaxed/simple;
	bh=ZzAmcGyP8aUwhsrnZpLdsWba0OsBlxEFuhMw41Edfsg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lBHM66vrINvxVvWwug5R5/kolIf7Ar5+xkfPJHqzfHH4ld4wY3HK8MBVohiZ+FGV0TnvEXMQn9Gw8Mx8+MIj6509yePcQK/cLjdlWn2kQd64bTkaobpWoSTTxLCnnR+e7+QOuDJNhODjyNxtkjYhwK4Z6gpyxjDPU2QyVnWacJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lF4/d3aC; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lF4/d3aC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720737342; x=1752273342;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZzAmcGyP8aUwhsrnZpLdsWba0OsBlxEFuhMw41Edfsg=;
  b=lF4/d3aCOVrXHA2K5GUH2orNM/j9R/kurmSTDabVH7ky//FBxL3iR1cD
   KZmYyKjoYNwq7vX4m8KdI/yHziqRXqhrm1+0ymfLSIMovfzCmUqU9ajjR
   3soAKs9e3l2gr2+ijXifP3yDx+RLz/hECBxvEodH5xQlKLtgLK736+ZIl
   0B9yTiSe7RcY2cPoOnxwp2NhTx35g+Wbz+xFPiH1fem4crGcvobgsmV20
   MFgLPDNTUxI/DzPh32Ux4CCDOlwL7SWISXXQmB7kOxozglduJdQKsT8Te
   EUp2TpXTeH5B8j5uMysfDWn3swXz9hIhg3LtRv0flpPhfeOb6NVJkz0i4
   Q==;
X-CSE-ConnectionGUID: +ykkaOIsRgaixHYsN1bE+w==
X-CSE-MsgGUID: maUrZc2tRUuSnni8jVaKAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="43573964"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="43573964"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 15:35:39 -0700
X-CSE-ConnectionGUID: lt23Cps5QCmM1294PA+zfQ==
X-CSE-MsgGUID: SfNx5f4NTCCBHTw/WyoR8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="49369563"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 15:35:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 15:35:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 15:35:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 15:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyWa1AMBqbkefaCOlZidsuLzztR5HUj2a61BEwZqTbOOXKuHV/WgFMynK3a/CQykO1Gidn8LMRgZGbC5XiG9VFnGC7AyZmQmGI6iunld6s1ekHAbBlKprJPpuhYWY7/Fu1IO4EotLuB0GgLiofdRDnXtjirznJ4moqWJweYG06bjCjJrZ9MMGic4Qa1YDVx66RDTbcUktcitGDyWK4q35W9XFnY6ShZI+bni7rT039nTnDZnnsvyi503x4Hbegh3SYE7OLyeGic4Gl8XMepBVJCQAvwObQ2csxOG8QHrxwiL3HAJ5F2uNJQBNwYTmHNJ26T2IFjyFFNJQRgu44x7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQXhnMPlxldiomx9qFWAqhL/+hmYd/G8SUENNPP9/1Q=;
 b=OeMzZzZ8iHMAYiGo+im56p50EBtOfUAwQ70Ml7j/0qeHSLK1iAqyplwM3vlVMy6a1ZGi5XFurUXF8TUIHtlTOQX1y7iP49mCP38ciSLwb1QlcfTpom1WfDtBffKdnPi9XXcOzyhdiUP+iVoN6QyowlvOrNuoYZohiTxN8sJ5m05YVbPrbYamDpwNWrWJYaQRkqZP7pnok2ZmoBeet4fgRnvA4xhqdWDhWRaI2IpmqqL5IduBNLS6sf05/6Xtwj5xU3y2EIwIMoFfAajBdDtZtp+XMzcURrjvgMo8Cqoi/u8IL7eLTNtgnai0F5lD6jmlbKG0sOBpn5cc97h2lgGNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Thu, 11 Jul
 2024 22:35:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 22:35:28 +0000
Date: Thu, 11 Jul 2024 15:35:26 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Diego Garcia Rodriguez
	<diego.garcia.rodriguez@intel.com>
Subject: Re: [PATCH v4 2/4] cxl: Restore XOR'd position bits during address
 translation
Message-ID: <66905e2df38f5_1a77429467@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1719980933.git.alison.schofield@intel.com>
 <1a1ac880d9f889bd6384e657e810431b9a0a72e5.1719980933.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1a1ac880d9f889bd6384e657e810431b9a0a72e5.1719980933.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0201.namprd04.prod.outlook.com
 (2603:10b6:303:86::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 998533c2-3e26-489d-4d9b-08dca1f9c3f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nNneguP6pKOVH2E+cxRBpI0YEsRlcwNfJ9hj3GgVEaDnySYpRpoYA9KcC7Ib?=
 =?us-ascii?Q?7E8FiPlKz/Bzy4Yy7iQS4ipY+zcp7fQ9Nhh/2PUe0/bKzfpwyGfT3kd0iteE?=
 =?us-ascii?Q?zWoz/z/q+VC6yAkrNGSXOdAaOffJf6u0VXDhDxhJG727Xl3VPug3phheNCRX?=
 =?us-ascii?Q?SHERpWkza7OGKPKRvM7SFme6hatjEDHwxNgmpaepiGoabtsWlVqDJ3HrbIBS?=
 =?us-ascii?Q?txXaBsfavK3vF5js0B/eHlt2tJQ9zdVqwbx4ykJ8J8JYNZjmYdfpc0zZSzBD?=
 =?us-ascii?Q?kb3k+zKqHSpZRI1OaEsCIlNIO6jUZuY6Bp96sIzTo0EV9iP9F/wuLlv7QfRb?=
 =?us-ascii?Q?4MU50Qo8R/ltbiHr9donQk4A/ob41uLOKVJH5twveSfPffXzcisvh1C7zNhQ?=
 =?us-ascii?Q?dRGUo835GyRfhqw7DrzLIY8nMrJ63+HzgUS/XuCGv9Nlq1/WPSw8zoknORFS?=
 =?us-ascii?Q?fWuyu6Lp8ikvOEODckWfp70K8w6CKz0cOmun6YLzBtNjmL+Rs+KO+TizFJUy?=
 =?us-ascii?Q?LjyKiFb5WMpaHfkjM1t/ZaW44OaOzrilHrUDY1Lk3JrYBFKgEVf/7/vw7BKY?=
 =?us-ascii?Q?Acx8eInJYwcJUqrXZXElHdYxMDIk1JMnExk9zOd4TfdpO4TX48IVNSL7s1IF?=
 =?us-ascii?Q?csR6sRko5SZbx0MXSDfBtTfGoFoojEh9d9/1GSIkvH7TB4vj0HIY7C9760eZ?=
 =?us-ascii?Q?OI2JG6+X1ozRH/oEmUeokVokIqyrnI7AOFOVaTuWwDDzUPooofUkZFmOQDiP?=
 =?us-ascii?Q?x3KnD8pOZN5rXMFK3vh+qzA7OEMLsqrzBFY0QRgtW62vEJokwWvXrGnq06+O?=
 =?us-ascii?Q?LNO/cs0enP6XEfHeCWmBEu/FfBaiWkajmbsIiI3/XWpZ1TgXQBh4V0lsb/gX?=
 =?us-ascii?Q?9O0agIc7XcouFATvHmmVnX3E7oUunu2u4ElNbi5s1Fxt0fqcGDZN037qZLpo?=
 =?us-ascii?Q?RQnc2Dkliu4CrAZqmyk2c5B8XVExg1uIErOxAAVTOjViT7k/mmNrFmBpyKx0?=
 =?us-ascii?Q?UJ6BkBr7AnDOBuwJREBZypPHT/Jp2LZwIQTYcbKfEia8Jr3b9noNpa6BJXJm?=
 =?us-ascii?Q?osphDq3ztv8BBsxYaEHHr8jRt/8DXxJC5iFa1BDLhhsPYoEGi0gPQt6YF7fO?=
 =?us-ascii?Q?4jI0/wtfEY6EtR6Ve1OzlSMcajq6e9/U6HVgYhovq3tt9OFra0KVuaJyAxcR?=
 =?us-ascii?Q?IJtvMhnqXBzGms//cHfcPjtepRlWqRG+3K38BOOWsN11CTqxxwduXzrivk0t?=
 =?us-ascii?Q?i6nstlQ1V1ahRokJuRryYdWJsQFSjsKconR067NAT+wTkG17ODUdIxhTpVtU?=
 =?us-ascii?Q?oOA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/UZP4nWBRaIrFxN2/pSvcIiUR3SZlfqyJmIvlLhZY+JD7Ye4hdrgLdXSRhV8?=
 =?us-ascii?Q?+/vQRYmnWB2FOt+kkay6u2an34PdMMmT2/zraG9PwBOo6nBNNzsYOdRFO0kc?=
 =?us-ascii?Q?TI7BkfEYyVwuUU6tY3xsCVSDFAr1ZFHfxuzYSR9zsPnaWZT2ysA/wHYAAzkS?=
 =?us-ascii?Q?KvdabqjDY/VoBLH1dy/bwLkXAX1AmEsV2Bt81AbEYlV1b5e3rdyg/N366J+n?=
 =?us-ascii?Q?2d+ELikWYO923n7QhGnWRzEIsfJrWJg6/MyrYTKiH/5R2QxUDtytHVjc0C7m?=
 =?us-ascii?Q?BkvUAfdG1k64rZM++yNVBo7DOR34PAqgtrC/WAxvcH554+ashZ/JQAF+zt5+?=
 =?us-ascii?Q?hxgQJ0bCUmcK2q36tVmfGCLXVPRwnzbEC1IWmBXyLcxkq547fUrDvb9SfIFe?=
 =?us-ascii?Q?QGWlWkk3zN9PQFzLN78vG8M/PjOJxYjQKff8Trm+sBDhYMtmg9YwNK99v7W6?=
 =?us-ascii?Q?++jbkyjM9SHbZuZ8hv/rihk86IuVqP7dDbzLx5jKBoDbiK80i/kdU5maOmc/?=
 =?us-ascii?Q?NfstcHEtx/C9+uZEZa1/NFh2ptsPR2HSif+FDfY+o36Lt78iaKvQspmYzn+o?=
 =?us-ascii?Q?Wb8i0CfvtFuCxvXJJRdEAvvEwo/rAsTYrAlA0aPO67Pj4/o6WEGGfnRWKLX7?=
 =?us-ascii?Q?IenXoxlBePngExU2XARLwvVbFh0cbyL81DxDALJ7+ZJdJxOOfCG2/dxjZPF2?=
 =?us-ascii?Q?cleDt/V+7TqpCFl2kyQOY2Xqpk11C3eg/w4VWQ+zwTi1ZoYLZSJ6A4I7qT++?=
 =?us-ascii?Q?pxRzxDLb28Rquul8d+hGVVDDxVyg57MWqhY+7EG4jI8RYzqmKI2HF6JI1xnJ?=
 =?us-ascii?Q?qWVdXdJi32RC429MevjMFkexe5gMQUwMdHSVZK/Y4q2bwclBv8al0kIb8Fat?=
 =?us-ascii?Q?Phtdwb0DT+1oS0DfXLZNQftd3TqD21av8g6Rk/FW4cFazqg/ERhMnhInY9Ok?=
 =?us-ascii?Q?iEGq5viCo9E/vxdRBZr3EB5uwyMb6w4jDKCRKhgNOP0v7QdJiA/ODXf4PtcK?=
 =?us-ascii?Q?f4KB+DSppVclQkAthfEcpZAj2rTvkM2d7Df5KqIkZUHuLXudYF6abenf3BL8?=
 =?us-ascii?Q?HFYJFb9rsqzO82RW0QwnQgtncxiL4oaiwRt5MaLCPrzi7mXi9cXnPo0rIHOi?=
 =?us-ascii?Q?+9n5uJzmZ1wwgqEGLiB7uHBRnBdM2d2ElqmawMY+k9BEHxq3DnDVS5Y6x4nF?=
 =?us-ascii?Q?11G1OremA1hxkQhlHMOZKADfDuv7o5xAD2pokJk1mjp2PXtip9ypaQxLV+L1?=
 =?us-ascii?Q?6f8zEcQpxbPJTiwbv0twlTB+68uqceEVjZMsTeGt457E1Bp35bdUuTaV7DS6?=
 =?us-ascii?Q?pVbKINXLU9KWLv4yxqi6mtzdiNE3QV0JN81aUjm8wYIufKQVlMrNiPuiMVrD?=
 =?us-ascii?Q?7gQXtWVexYTNRDhbSs5fZNCiKaOsknqHVUMb/c2lhr+A05pv7HPyrTLDFpg5?=
 =?us-ascii?Q?+lppsqvaVSSRj+1NVVBlX/SQjIQ56+aK+dbZLHugDzvH15j6fEXfZWDOms1O?=
 =?us-ascii?Q?3ss1wQ+umfQnC4z+IDCr9I9oQEJYXEJ3SI9mSvBluFypt4fHkvDVm+W94wv7?=
 =?us-ascii?Q?NGhH9rmS3NFHMUTtIHuoJG8XNeqOZ0IFw4SFIJ604L7HsIcI3TiQjl2YIHpI?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 998533c2-3e26-489d-4d9b-08dca1f9c3f6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 22:35:28.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHMWsZyjSzmNplg2HHMLk3muwdnIDQzOjJqq0CdeUnzOlQUsWYlWHn8mrw6YI4z47E0aa9P7E+J9vi6PrHqhuQu6WfAFHvy+3wLoAHKhmy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a device reports a DPA in events like poison, general_media,
> and dram, the driver translates that DPA back to an HPA. Presently,
> the CXL driver translation only considers the Modulo position and
> will report the wrong HPA for XOR configured root decoders.
> 
> Add a helper function that restores the XOR'd bits during DPA->HPA
> address translation. Plumb a root decoder callback to the new helper
> when XOR interleave arithmetic is in use. For Modulo arithmetic, just
> let the callback be NULL - as in no extra work required.
> 
> Upon completion of a DPA->HPA translation a couple of checks are
> performed on the result. One simply confirms that the calculated
> HPA is within the address range of the region. That test is useful
> for both Modulo and XOR interleave arithmetic decodes.
> 
> A second check confirms that the HPA is within an expected chunk
> based on the endpoints position in the region and the region
> granularity. An XOR decode disrupts the Modulo pattern making the
> chunk check useless.
> 
> To align the checks with the proper decode, pull the region range
> check inline and use the helper to do the chunk check for Modulo
> decodes only.
> 
> A cxl-test unit test is posted for upstream review here:
> https://lore.kernel.org/20240624210644.495563-1-alison.schofield@intel.com/
> 
> Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Tested-by: Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
> ---
>  drivers/cxl/acpi.c        | 40 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c | 23 +++++++++++++---------
>  drivers/cxl/cxl.h         |  3 +++
>  3 files changed, 57 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 571069863c62..6b6ae9c81368 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -74,6 +74,43 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
>  	return cxlrd->cxlsd.target[n];
>  }
>  
> +static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> +{
> +	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> +	int hbiw = cxlrd->cxlsd.nr_targets;
> +	u64 val;
> +	int pos;
> +
> +	/* No xormaps for host bridge interleave ways of 1 or 3 */
> +	if (hbiw == 1 || hbiw == 3)
> +		return hpa;
> +
> +	/*
> +	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
> +	 * the position bit to its value before the xormap was applied at
> +	 * HPA->DPA translation.
> +	 *
> +	 * pos is the lowest set bit in an XORMAP
> +	 * val is the XORALLBITS(HPA & XORMAP)
> +	 *
> +	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
> +	 * as an operation that outputs a single bit by XORing all the
> +	 * bits in the input (hpa & xormap). Implement XORALLBITS using
> +	 * hweight64(). If the hamming weight is even the XOR of those
> +	 * bits results in val==0, if odd the XOR result is val==1.
> +	 */
> +
> +	for (int i = 0; i < cximsd->nr_maps; i++) {
> +		if (!cximsd->xormaps[i])
> +			continue;
> +		pos = __ffs(cximsd->xormaps[i]);
> +		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
> +		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
> +	}
> +
> +	return hpa;
> +}
> +
>  struct cxl_cxims_context {
>  	struct device *dev;
>  	struct cxl_root_decoder *cxlrd;
> @@ -434,6 +471,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxlrd->qos_class = cfmws->qtg_id;
>  
> +	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR)
> +		cxlrd->hpa_to_spa = cxl_xor_hpa_to_spa;
> +
>  	rc = cxl_decoder_add(cxld, target_map);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 237c28d5f2cc..23abd0f7b856 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2723,20 +2723,13 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
>  	return ctx.cxlr;
>  }
>  
> -static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
> +static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)

Minor note going forward, no need to respin, if the function is static
then it need not have a global namespace prefix, so this would be ok
renamed to is_hpa_in_chunk().

>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	int gran = p->interleave_granularity;
>  	int ways = p->interleave_ways;
>  	u64 offset;
>  
> -	/* Is the hpa within this region at all */
> -	if (hpa < p->res->start || hpa > p->res->end) {
> -		dev_dbg(&cxlr->dev,
> -			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> -		return false;
> -	}
> -
>  	/* Is the hpa in an expected chunk for its pos(-ition) */
>  	offset = hpa - p->res->start;
>  	offset = do_div(offset, gran * ways);
> @@ -2752,6 +2745,7 @@ static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa)
>  {
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
> @@ -2801,7 +2795,18 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	/* Apply the hpa_offset to the region base address */
>  	hpa = hpa_offset + p->res->start;
>  
> -	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
> +	/* Root decoder translation overrides typical modulo decode */

Another minor / don't respin quibble, I would not say "override" it
"supplements" since "overrides" to me implies that the dpa_to_hpa
translation is completely replaced.

Otherwise, looks good, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
