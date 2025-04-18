Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934EF2528FB;
	Fri, 18 Apr 2025 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019742; cv=fail; b=f0c3YjhiFKg+moASpJTJ3LHSBn2ITKezZSuDoC3071I33WJNnq5j5Oe98JHqewDlXjcoDvAvzR56M6mYlQ5hNj63qSMZxpbYkqOZ9jPEm3MJZQv4QEKnhkczvwx7uqUsqhvXiTGsSaMPheelYBTauz2kjNx+nUxUd47rhQjP2Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019742; c=relaxed/simple;
	bh=8LiycUyxH1+p09WIRLVrNtbh3o6OlWfD5JTkCS2gznw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fvom+Vrhph/hqMPaBMNA3uNBMwv7wRnV4dj/RMP/PgU8Kw2UTSjbRCgFlRfoy3vSan5JVTmmoSXWJmpsaMluMKw7GZ9yPElRNmMXPFyRMpi3vi0GjQbv3R6iFVHPZrg4wBMGjjmvp4h3AL7ky7TCM06LNc/T9Dvndr0sFFxysXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEIsdMVz; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEIsdMVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745019741; x=1776555741;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8LiycUyxH1+p09WIRLVrNtbh3o6OlWfD5JTkCS2gznw=;
  b=AEIsdMVzW3P+5Iadz094k1YzmDKMw6ZgvEslQyThyJOxzLbl3fwX3pHp
   5tTN88FyL+94xUcwO986lMqR3E6DWziFo2ONg6f8xCUBTXPOq9hZ+6Twz
   e2kNaBYfTDTbRBFWs58bz8QvZGy/RV0bpoE1HuD4KiHbDyARDcbJVT0S8
   Huk5ApDf5XZnWserC5QL50oWazCAXB7+kjZSfF0LYMDmdpQxg3Ro2RHYL
   98EnNpbVF4veGN9BtBN8np7edk2XfHZwWDli/IUDsGPnDAx0uUrH+t08I
   dsHJ6KwMWnLjzoTgmB5PxZsIw/mtsWrSvl2UREloc0WhfFPTK/MIsPW9i
   Q==;
X-CSE-ConnectionGUID: agjSNVJfS/i2ealPHXu1tA==
X-CSE-MsgGUID: +uYWzUfPSGC1+kyqV+xi+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="49318335"
X-IronPort-AV: E=Sophos;i="6.15,223,1739865600"; 
   d="scan'208";a="49318335"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 16:42:18 -0700
X-CSE-ConnectionGUID: 2nt+oPuCQhKu2kFOChN00g==
X-CSE-MsgGUID: BcMYnLfvQ5iXYyfVPBAHbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,223,1739865600"; 
   d="scan'208";a="131531810"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 16:41:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 16:41:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 16:41:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 16:41:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uONlDKugncRIarRH8hJ9NiVWrOWVc7fqhflDHRUh2ZPsrtlnZIikMIqskcO5EriGEFxmNv0hDOLgxXAiAgAUAK/yKvn5mJm8aqKHxImuEso5EAak3KOjsMbCFleXbepKMsv/68Uw/lg14x296k7IeLvC2WCr96g7TNDjByHXuyzkCIarzTDK2R7oSCEFI1ALVjJXq8jdb2PDUDJJ8xcLPPeO0MkmMGYZCKNfFPLh9uRm8jt6/iVLY4tUOKUvynFoEPUR8Zd2axIhBq7586ohB1o5F8lsNMIy6MCSK4DMZASYFem3IZ/GmA1WFRLlqnhd7vI8o9gOLkLZYacWnjLNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za/cLphzVJ8fkuNwNolWAG3d19FxfyGEenxGIoHpYR8=;
 b=W2PJDHbYcrU1yxIC9Edvhlu1eWPyGrJCtzh1PtD5wZ4C1EEucLOCB6UHD5rp7yUepa2jI/WTEbyVsqp89ZDRh/CMftU2KgczULDxaxOsrJDBPERC+JLzUr3hkHXrRSAWgkvtHNZyssovj4Rqrpzj47QnAKxqaqYm7XbGR78B09p5cpInwcipVb6J66wQ4ix5um2BuJkbM698SgmBHhNaelYRRJ/7QizgWnZgVM4qIWWYPzQhTv84edb8l9M2ypPLIvskN0Yu33Y3y7legVN8bTN+kwSxIrUYxdvw7XzImK+3TSpmUthPz5YfUxuJznovEWTUs5PBxnzfvKaJy70LyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5152.namprd11.prod.outlook.com (2603:10b6:a03:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 23:41:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 23:41:20 +0000
Date: Fri, 18 Apr 2025 16:41:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Robert Richter
	<rrichter@amd.com>
Subject: Re: [PATCH] cxl/core/regs.c: Skip Memory Space Enable check for RCD
 and RCH Ports
Message-ID: <6802e31da6854_71fe2946e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cfc89d-4f75-4f6a-6cdc-08dd7ed28567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jPt8NrPAPN8EMbP1CXEyAq+q9PUqmX1H3cM5hymzKy86H9k0VjT3Zn1fT7bK?=
 =?us-ascii?Q?tInj5t+x2kwKw4e9+iOuoST64BDZzcfNruiYYhMA7JAyRFLjFxrrK+/b7PBO?=
 =?us-ascii?Q?M8GKpTGazASPDF5/C4BSJ5quNc3tM8/fK9SATY26R7rEempdh1/zS0z18iCI?=
 =?us-ascii?Q?KOXCXz/Ej3HGnQ0CZ1/T1GHoQwvGh0kTkNgs5RRfIvGJldRZmQJOd77H774z?=
 =?us-ascii?Q?W4Ot+3xfSV7GxEniiBSQzhhbC074j7G26ZD882AAsf6D0fP2RtjavCcC/xnY?=
 =?us-ascii?Q?rtrdkja+E/d8QgPuhzbsatJqHB+nMhtNNVHViWp1u2hmHnmN4n+LH7+/sPdg?=
 =?us-ascii?Q?U2gCSUTr8M0M2Z1x2tQGS6Io/zyVr2simwqGZ2C5W0qZRNhhb8AL0fPWk17t?=
 =?us-ascii?Q?e5wcjAjhceP8oopYgIb4VX9jqqu0dBiZrD4MSLrY0Su8GX7v3c+BO8zXXgef?=
 =?us-ascii?Q?uzzZKY5JpflEoLg7NzH5yXrInURW2NGu7jZPOVg71ZHfHIPV9cZQZnjmo7OP?=
 =?us-ascii?Q?QLVLDAajMOwLTaDaY1VJQhHeKTRVd/Hy9qT8L2jy6i8uPLZVMro8r67Jlskr?=
 =?us-ascii?Q?5VnMrBTPKibZtQLHQ1dGx4U5CiYCuv9HA00dHkKgsh9eqN64vAhckAc09THO?=
 =?us-ascii?Q?dsp/IHBnWCY5vQPw8Wq5vICiwnlmOQMV7oDt+WI6P59NxjBr1hYxxwWAT4dd?=
 =?us-ascii?Q?29VynsqQxteYhDGGXg9CLg86Lebmacap01psjLjIzqdBZTw08W6dl74HZdUR?=
 =?us-ascii?Q?WLx09UQPRbu+Tcn3hKYN4KFVjyYThwoJedcdXzhpYY5MXwwRzNY+7I9UTF78?=
 =?us-ascii?Q?K1Qiaw6infK+xZTAElpqDPSnu4gYwv7EMx4NAk/6g//tiG7dqRXl3K8aK/FT?=
 =?us-ascii?Q?LX21EDEppKL6QZztqq+ZT2gxcCAsw2umIW7qCZDP2kkFD5Re2wu1pfzRB32R?=
 =?us-ascii?Q?OnCgmDLbd229cVhHwbVck8r1laXwkzm38XWREB0U2aW5ZEIjmrO+hdycr1+O?=
 =?us-ascii?Q?WeNqM2MJecoWjGVbtTAzh8L0yuPGX6SHrOuD7R87O5sx1vOGUAXQb8N3NhjD?=
 =?us-ascii?Q?u7m8HzxdlM51wWeWB72JCIRu/PUPjpocFdOoLBcoVq0y2jmPplewM5kZOXjY?=
 =?us-ascii?Q?TQcmmXz7wZgJJezmgPiP7PWNLyGbGDrc+y0yGSE/EntVHdsAH20G+Eu8QdzA?=
 =?us-ascii?Q?xrXElrhswtMKukCqiZJSSQ2N3DWtFeL7QF9snqe3Sp8Mg8Mn4QDvlEE5VKP2?=
 =?us-ascii?Q?8i8+yh/2V/d9gy/R6MhyTSUiZZboXH8yGQr5mMDrRh4fHteX9y/zf8Ko5tOC?=
 =?us-ascii?Q?YqMck8hNjqOZQMMtxkwfvRvs4AmaEQGvE71gg6fzvzI+EUk1GblRpgVnNjzA?=
 =?us-ascii?Q?yvYvUNBI5idbnQsgYmBkeuZyaVD/0QWOOQz5a3+f4eWOnBj+CMM6BQKJEzJ/?=
 =?us-ascii?Q?hJ0WO6irC2M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89H2NUpbF8BBvoX0reAKjTsx+crO859JB/jw7EBEPrpN6HDPT49NmqlJG8sm?=
 =?us-ascii?Q?QhUYsFHS/nlVzDly1Ejs0bHgzqxzyAuNnCM6ti5hPwqkTawNLfXo7YBn7I+b?=
 =?us-ascii?Q?KsqqQeDu09UPQTFYLxXsmhQi7CXwNgxXzA1eNtuOIh2YcEEYQZqu0uvzoa2j?=
 =?us-ascii?Q?ulmUc0eTooT3UwHEkUhlXvDcTtVrJPt+Da0SO+CDQR0lG/gbew2tny2TjbJ+?=
 =?us-ascii?Q?Ogjq9J+sJNOftvM7tpeVIpJm7Xh5XZ+i45KSNVoOzzEwXugAHWRy4Ot8GPn2?=
 =?us-ascii?Q?1jvj4sPgcZVdgMBzpJGTZLA+4MXC5NFnXeNgB/gpZIpPKePA/Jge8zrgDdnY?=
 =?us-ascii?Q?PpT3bkdrW0mtgcvEB7Cw2p4rX9if8mRlHE3civUN/c3r5UFLYUYOow3oKIV4?=
 =?us-ascii?Q?W+Ads5vZPZ+deu2xXhtUiyhpJsxbUuWpp9X8rKBFMIQ/LaF9lhETpoonfZmz?=
 =?us-ascii?Q?WnCGA/8w0uXWrgW7OYnZ9q+YswywucIwvG58SNvwYJj7oWYTlR1gXY5+fnEU?=
 =?us-ascii?Q?d9y490i5eNOYGcz7Iuy+DFvjHVU5B0nGSqV79TYFGT4WvHqf7AVcwnYRv80H?=
 =?us-ascii?Q?uAaq0YHs+LPeh2hiqQDc59+yQ5yL4sX7gNNynYqdJPQpqLoQdTBbuo0gYwWz?=
 =?us-ascii?Q?q95UQJsXpXBUsDr3h3n2lC47GGxDW9zBGesQQUncxlBWSKJSsToAIJQyoj+R?=
 =?us-ascii?Q?ODgISoJgcIl6E4H/6mZ8bD8N82Ov8hS7e9AEjM7OUjNtxVzLRTpCgh5MNtsC?=
 =?us-ascii?Q?PJHUd30eFaG0YLlAISerHbgGz/3UrPL4XuIOyu+FSY8WRQfIwqWSJvdSazrv?=
 =?us-ascii?Q?edMakjnLJhYG6teDHmOmyR9RxgJbsb3tsfGoH59zYI5VRt1VKw7d8XMXEqRx?=
 =?us-ascii?Q?1YOCRBiRPpmbWCA+3TwYcuIt62Sg+KuX4X+ArMRSicI4bk9UEcE7lmnwaO26?=
 =?us-ascii?Q?854uBfCkJlr/K+Ef4/Fd10Tv0QfG7vTY7phlxmQuX6EerSBK9uyA4DLirbgD?=
 =?us-ascii?Q?IerwemV6gByUrgRjICzlsSDIduQyeGlvA+JGbvgDQokkPdQswM6VohG5XzQH?=
 =?us-ascii?Q?cwLYa/OA5c50ssH6dzuXhrYdy/wQiTo0nwIdZQAy0UlbQE1iXzY3VBPJipzS?=
 =?us-ascii?Q?gaTQDUf9xYt/jkoQmsUAf9/vlU5EdSD1xYK4Mp71kCE/SEiChSBj4/U7TIfk?=
 =?us-ascii?Q?GbN5f0VCxVurDOWf8y62m+BccX6U2UO9Q7GgTtL7H5T+jDrYW7vQG/R8KznW?=
 =?us-ascii?Q?ioHCzqC9kPONq3dR6ALk78qRex15R4dPR5d87TMQFENReYMEUvxpQKVMPeQ3?=
 =?us-ascii?Q?DiurkjifnuXAOaUOFBLQeLOL4cN72woOCaKAu7E5jUyg2MoNBrS3Rr6wLCWp?=
 =?us-ascii?Q?bAIDRAJyOgtwxSSU6rA5cJr4/MjdXr5qTg8CTbfPi5KAZA7NClHMRHZ6pcK4?=
 =?us-ascii?Q?pU/pTiw/PSvYXjB0qJSokC/mITmsZQkMxOHZbyGoUfyB+dRssoDeHlqYIajP?=
 =?us-ascii?Q?05wfHnL6iw3y/Y40E7HejFgDvkZkb9PlFWKVCPDza1JAjQkCqoEaB0L6DxQo?=
 =?us-ascii?Q?JEAZhER5ipL63Bw/qfibwXUD8B3A3Tj2TgUoLCHRBCXI/lVtPcIrOt61WStw?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cfc89d-4f75-4f6a-6cdc-08dd7ed28567
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 23:41:20.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPohr67rtj8xF/WDBpxpZ8eR+/c81IMuklmF4ZoQKUq3V+jp3fLzjVxTvSKZX3f0ygXpZL8zas/ky6t0LX4I6RFEe24adlVuNihXJZ59m7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5152
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> According to CXL r3.2 section 8.2.1.2, the PCI_COMMAND register fields,
> including Memory Space Enable bit, have no effect on the behavior of an
> RCD Upstream Port. Retaining this check may incorrectly cause
> cxl_pci_probe() to fail on a valid RCD upstream Port.
> 
> While the specification is explicit only for RCD Upstream Ports, this
> check is solely for accessing the RCRB, which is always mapped through
> memory space. Therefore, its safe to remove the check entirely. In
> practice, firmware reliably enables the Memory Space Enable bit for
> RCH Downstream Ports and no failures have been observed.
> 
> Removing the check simplifies the code and avoids unnecessary
> special-casing, while relying on BIOS/firmware to configure devices
> correctly. Moreover, any failures due to inaccessible RCRB regions
> will still be caught either in __rcrb_to_component() or while
> parsing the component register block.
> 
> The following failure was observed in dmesg when the check was present:
> 	cxl_pci 0000:7f:00.0: No component registers (-6)
> 
> Fixes: d5b1a27143cb ("cxl/acpi: Extract component registers of restricted hosts from RCRB")

I expect this should also be:

Cc: <stable@vger.kernel.org>

I think the stable team always attempts to backport CXL Fixes: that
reference older kernels, but always good to include that to make it
explicit.
