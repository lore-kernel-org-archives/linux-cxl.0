Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605DE176AC2;
	Tue, 25 Jun 2024 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357270; cv=fail; b=t2M1cKzTzGfxQeVHE+oN31iHytuhpHN696C2bmCLIN5sAJm88JfDtoGnlnEAaM0OxRuUt0hagZx4GUsvAkJH1EZZHJwjC/Fkw33DBe466Ekr+hshBVinPIjVLeoZSpoPfE9uuW1xTyB9TSV7lhO5pr8WhOq7IaO/muhWvAN8cfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357270; c=relaxed/simple;
	bh=YpI69UPm9GTqCtaKPvQJ3+1jQJoD+SO3z1PVO+3/Gf4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ahVKY4Bym5+ZUPaDXt6PuyQBUAjQwovyA01ypdyObuGNCVSd8f3RVnEJERIS2WuEDTQRdVjq+RfDzFgbxUfiC0pSVCQN0VoxGGyhWQPabKSF1J/M640GDVjFhWbosDt8/NhG+lxxzKvY17lAYl+HdgqukRY5Vhy74QQaI7Nmggw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=By3IVdFp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="By3IVdFp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719357267; x=1750893267;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YpI69UPm9GTqCtaKPvQJ3+1jQJoD+SO3z1PVO+3/Gf4=;
  b=By3IVdFpSNnx6koRjsNO3eGIm+PBVpYIVj+ZRyFN5Gr/RU528rMzAswD
   kmSyhLuI3LSfXZMsNVhzNdByPQRUC6wp5UxXiRmdzV9OYpATh6j3LvdcM
   i9wr87RM/+6dWJzrNpkFWaWSa+c4xRdy13aCouhZfkITmSFvH8NN4iTQt
   M2FarZ1ZdD0l7WISke82FYDs2KfAWEJTFJpMVCNP4Gn+IEjq/blYC0OJ5
   9yyCxmYfuV8dit4a2nfpaWbzaBgTNU3dVYmVlZqQ+2aGeNNQPG4LHTes+
   xtnXp4wYxL162OzuQsfjRuf9FaMfpNZ8oiEbtkp2BoKjD2pHiOSncSo6h
   w==;
X-CSE-ConnectionGUID: 3hxCc8FhTWqWCy2gTaRcYQ==
X-CSE-MsgGUID: +RRJ/ntHSk2qcrfwcJbmGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16549693"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="16549693"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 16:14:27 -0700
X-CSE-ConnectionGUID: WyGL478/QVeHCd2g7Qxb2w==
X-CSE-MsgGUID: R3FSJ97CQsG9Wi6Vk5lP+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="43914289"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 16:14:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 16:14:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 16:14:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 16:14:26 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 16:14:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CShnSHkamSUy57nXCENs2eRFCY9iY7Tvbt3QfVQMrsJ9GO0zyomp55TjrNVs+J2ja/fYMUZ4fo4XT8qNkYcPu9HiR9+H96GS9RzI67J00A+krIP6jjI3+z7ATDxvWuuAGR+c5ovpuDCSUIO8iTDEyCo0+2w3TOkiStiU1KYRH5vo/EJIp2JsAD12jv2M5czJ0x4BNmMvrUxllrF9bNdEUS4ze18vsQ7D3532johZj/mZgiOYjmnnKYvxfwOec8jZxOSnuiyk/bhkNZ+GB3S4NRtBkiWugX7necLCbyrjTTJwZr9FY7/tRmxbM6x7phoAzGNa7U8wo7eImJHeO4twNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ8xWSGavCO28937ugMqfQlrKaP8S+nG25FzGZ9S5WY=;
 b=C70J7LPtjXEJWbjaZ3xmdXVdo/liHi3KFE88NPe/krA4BqgF6YWwDbGnDQ3gOjWLxHHY3yAmhJAIlRAPzAUQgnupbqjnihpV4h6/oDfz/ytlvrAdp4oueH2PDAX6zYfDOwtzGC5RFX/ZsT0BECSwq/kntnd6N15Ag+Ad2m1y5wnFcSS/wKoUMch5VvSxqb/KqlS4bMq9xIgBuFsr80xgm9HtKk/eep2RpE6clwlafaGAUr6FTHoF05Y1FEEvmNckV2A+gm+TaOUc1KF7fYTx1n0UG08+N2LxbVL5qKi6MMxw1yrIDk3kFW31V0yPvyk3oPtKPW5fuXzv2tCxZ+GiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 23:14:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 23:14:21 +0000
Date: Tue, 25 Jun 2024 16:14:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH] cxl/acpi: Warn on unsupported platform config detection
Message-ID: <667b4f4a46cc6_563929472@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4824:EE_
X-MS-Office365-Filtering-Correlation-Id: 44dadb47-a621-42ca-80a5-08dc956c8b9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022|921018;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xLNFcY6VJKOrgCvPLoHbidn981TQaOt8F879RdoJoLo89duEMRckB40UXpgV?=
 =?us-ascii?Q?ZZien6G/KVhw/XpS4kVD1lLlMIKwbUfNwHg7bf/ixFfpW1ilkAvs/PxvyZUl?=
 =?us-ascii?Q?HXc8qICDh+xe1HH8XkxaziZag8IrHhuIJYNfbGVyghV8AYSZW/k2vIljtNVq?=
 =?us-ascii?Q?FfcrgWyUXbQq9ni31AQCGDvZGZdK0fOMpZmBWQcbLKR0d9yMS7+oXo2EFOI+?=
 =?us-ascii?Q?ZqQp1xQPNZdqSdELGkJTcz6HwmgbfPW8ass7BPvqhQOqKnLS4SwFzuJNSVcC?=
 =?us-ascii?Q?JZh0CVefFc/aLeu38bNS2Cm1eHms7OJ4f13lT6/+QmUiTJfd+THvUFVEzJvp?=
 =?us-ascii?Q?AnTH1JNq/UkkRRJ+dYLte7uDPzSs6GmfTG9fk77EjQhOCuOLrED/avV4foRr?=
 =?us-ascii?Q?WtaDi7fNElUXPtkmuNLDRk6By3cJ53cQIBWplkhoPp7pGMhzlU6sGj3ahVq9?=
 =?us-ascii?Q?fZJcLI3HcF/TbLT3nf1QB7I0eDSkCgmGI2e58DbvvbucUkWOaJMvlGr4ou5c?=
 =?us-ascii?Q?6rVPywmNnpWZ0fGBvWKXQJAb5fOLjOE+1dr7cr2Sy7w7BXpqu+mlfsH93+c8?=
 =?us-ascii?Q?tkStFwcePgH99MBz42qVy+SVGfTqLdJMeUA8qqdseSbMnhKktAdACm6yVhyl?=
 =?us-ascii?Q?o5VKh0Sebb1Leg5oMqhcpUGqpBQ9WGdDZtuNMMxpEyxajQfNhLC7EpoBoTB4?=
 =?us-ascii?Q?cN1p1Eu0eKA1zDQvd1ToJ3KvT2xjnIzi703gsyAwEOoAmvqVXUrRZ+cxVVkE?=
 =?us-ascii?Q?Q7EIqGB30utngRHF0pka4Whqr1fxMhmNo3i4hSLT635XcSILedy7Re5BlOmR?=
 =?us-ascii?Q?kBZUDTmGZeDz0NT4nQTiZcgaax6wQ90e8w036jU8rX2898Xrtau1TvUc3FxL?=
 =?us-ascii?Q?9GfSKRzrjwO4fG/Mwz2t+xvKMCyzq3VPQ5KPKjjSHmH/vJE3H35pDFuckfDo?=
 =?us-ascii?Q?rULCS9244E8y19oapRlYSgJ2OJGAdGWwTUY6EupfYEhQptwKeOyU4AlqYsHD?=
 =?us-ascii?Q?he+9Dd82U38M5Yda+XFxPJr5UrTLwxaAzbZ1Gc9cNtbhdAlrZNiSBZ02FLs8?=
 =?us-ascii?Q?YY50EA3sYNG4G7zz0CShPUiAkqs0KMXFQOhnLp3u96HDGqhgPW5AYCZbW2O5?=
 =?us-ascii?Q?YlROumPFrBGnCoXuouSfVPargQiiiUMBtTluYrPQsba/uyowhTa2cnOtxoz7?=
 =?us-ascii?Q?ixIeHaAyafx4EatdFFi0sskcjuexI3TI094yf2uBQIrMQrC1UNqTRMLKxF5u?=
 =?us-ascii?Q?xRgAopOSYTUlXvFXp9tnN/wB0vuBqCXw2wrivvfG+duo2TwnTKArpshRVtuR?=
 =?us-ascii?Q?rGD9FGlrdvwBFMch/3dUDvXnBruMRgdSBGS5fgwkdzmV3osMFaEVVteLoRqV?=
 =?us-ascii?Q?dZ71kCvxtJ/8ZAhl8qqxlDiCxR/z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(921018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8O/nkk1kSVFyWv+r7HHE9n32K70B6FEtmqsB6BABXjGWiLfPTnUHAdVdvkHr?=
 =?us-ascii?Q?hNm0BSNRKvf3wqe+IZV3EjiUTp1DxZtcQFUXRmd+kHsxpdD0sYPDXC4NLxpN?=
 =?us-ascii?Q?5qymlK0/sgCvzeELpkEqjPHA7l9zahYlFkHYlHdVcB9vQTXBydz5S9LWNhHl?=
 =?us-ascii?Q?+Wh2plLDkURgSMYiNHacRrWlIdJ958UwTKvhkpOkEXbW3Il4XoiQVe1iITFk?=
 =?us-ascii?Q?7UOhNnrTkXByP60R1bbEcCrszA/PaYgqpRFJKkvUwwqnqoxVkHj7CtgEqDJ2?=
 =?us-ascii?Q?Crnywe8RSOg7Xrfkc8pEgmM2B4V4Nt1h7/JvUSkferyjH+9nYhoG4yYZo0Vk?=
 =?us-ascii?Q?jrW+qtceTbwBBAKHCAjYs6yKpV++gieLM24h8eKofVLoD58myEhVTZjjls5Y?=
 =?us-ascii?Q?cXSIxy80EBDiBABCI7kCnaUxzyfMOIUc+xtvCpaI/P0PiuD0/klHWbbE+PKw?=
 =?us-ascii?Q?IiZYzNSh5q1EkCzZL30NjNw5WkPb9gRQAiUSV0FEu8JsN9strOObqNRCMxF6?=
 =?us-ascii?Q?f6WwgKhRouf9HmLs8fI/8ms9HqoPOpdQW9R03gXSLAYn1wytalxTB02h8Rib?=
 =?us-ascii?Q?M35cbllVpNRXOfX6sXlvbiiu6UVDvkPCW3tAlcxTQiaKFvc8hiRdypU4dx1h?=
 =?us-ascii?Q?H5X+xlOW5q8GaKln2LgKtnCVK7A8pdaBG1NcasMo9mA5gm03jc1D0oq3RWtf?=
 =?us-ascii?Q?9zu6CkiTXSJh+YYyVJdfVOSTWgc+3mdOogvxuPt+0w7IXw108GTckZ2BmHM7?=
 =?us-ascii?Q?ajAszaZ6c3O8PDgRSzBVAMh2jfmSU1yOcsRwnOYnwPc8GMxUkYk8jt0wup05?=
 =?us-ascii?Q?wIEKp84HQauGIDtIeT9i4JinQF+IuzkwyPV72vi2gz4DPYIj3eqw0fE7OFd4?=
 =?us-ascii?Q?We+mLiNw9EHSrFKzBdr0eOIOVTMt/Xw/uP0BgedphZD7kjahDRJJPMvs4b4r?=
 =?us-ascii?Q?0WTrgLk+WTFskpH7YSlR28m5/O4+ZCWJeR5LL76RJQ3uAQ3bVHQBWexRSaN8?=
 =?us-ascii?Q?1YW14s97i+IpAVQuXka7HVymOAEG3C+1TnvHzN43pmeJHXvbMMnLDZjEaCoU?=
 =?us-ascii?Q?rQMUnpNlxP4lw5/jsIyQo9KVJUuIDBtBzoLtT0cqqsPAgaYzh+Sz3LjZmJmN?=
 =?us-ascii?Q?zSEGrbnrNMi5BIkn2w+H5C8PyYZwB3uxghMzwbUgDlZu2lZlbEn8hOBw61pH?=
 =?us-ascii?Q?GHfRpbOkA6YdN5L/VmEymPdD0R8VyKZP46gpTXwSgWjkEgoiNHOrNHBwAGdl?=
 =?us-ascii?Q?pQb3B6FlgUcVVBJI6fDgm3qU1IArFN607L0DpybMTeZcEFWYNMAvViFkI7dc?=
 =?us-ascii?Q?qKr44wTM8XDuMk5Da6C9CXZ9O1nPBHOINVmiEJ1FA0fkq+q1pPymUsWQgt8x?=
 =?us-ascii?Q?kAVnmtlhIoldev6xEfwnKW0t2X42r/VSeF3hPLKyiWSzB+ZiJ3Ppu0JUeKJx?=
 =?us-ascii?Q?7tef3i6Is8kfFeFYlYRGYU5lvMqn/poWj166gF/h7fLWIHZHgzl9NrrzWW0j?=
 =?us-ascii?Q?tbNxTsLVsI11t7++isvPFaYfhSAfqIwWgDZ4ESNW0OO5YRjTR2TcTnTTWe/G?=
 =?us-ascii?Q?WlNgAmxnt+9ZWdBaJsyUfEc5KBhdepFBwk12jYPd6KADtLCh+suCegMXSmEB?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dadb47-a621-42ca-80a5-08dc956c8b9e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 23:14:21.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XViSpwaQPzJCpeGzME3q8ADagHqVktmf0sRzC0ze7R5Eovu5AuJ2DOjo7oytA/5bSkGDbbzOGokx4j1eUHHWsQVwN8o1KsNedrheUY6R0D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Each Host Bridge instance has a corresponding CXL Host Bridge Structure
> (CHBS) ACPI table that identifies its capabilities. CHBS tables can be
> two types: RCRB and CHBCR.
> 
> If a Host Bridge is attached to a device that is operating in Restricted
> CXL Device Mode (RCD), BIOS publishes an RCRB with the base address of
> registers that describe its capabilities.
> 
> However, the new (CXL 2.0+) Component registers (e.g., Extended Security
> Capability), can only be accessed by means of a base address published
> with a CHBCR.
> 
> An algorithm to locate a CHBCR associated with an RCRB would be too
> invasive to land without some concrete motivation.
> 
> Therefore, just print a message to inform of unsupported config.
> 
> Count how many different CHBS "Version" types are detected by
> cxl_get_chbs_iter(). Then make cxl_get_chbs() print a warning if that sum
> is greater than 1.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/acpi.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 571069863c62..9e226a65a5ea 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -482,6 +482,7 @@ struct cxl_chbs_context {
>  	unsigned long long uid;
>  	resource_size_t base;
>  	u32 cxl_version;
> +	int count;
>  };
>  
>  static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
> @@ -490,10 +491,17 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
>  	struct cxl_chbs_context *ctx = arg;
>  	struct acpi_cedt_chbs *chbs;
>  
> -	if (ctx->base != CXL_RESOURCE_NONE)
> +	chbs = (struct acpi_cedt_chbs *) header;
> +
> +	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> +	    chbs->length != CXL_RCRB_SIZE)
>  		return 0;
>  
> -	chbs = (struct acpi_cedt_chbs *) header;
> +	if (ctx->cxl_version != chbs->cxl_version)
> +		ctx->count++;
> +
> +	if (ctx->base != CXL_RESOURCE_NONE)
> +		return 0;
>  
>  	if (ctx->uid != chbs->uid)
>  		return 0;
> @@ -502,10 +510,6 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
>  	if (!chbs->base)
>  		return 0;
>  
> -	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> -	    chbs->length != CXL_RCRB_SIZE)
> -		return 0;
> -
>  	ctx->base = chbs->base;
>  
>  	return 0;
> @@ -533,6 +537,10 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
>  
>  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
>  
> +	if (ctx->count > 1)
> +		/* Disclaim eRCD support given some component register may only be found via CHBCR */
> +		dev_info(dev, "Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.");

I believe this is already queued, but my personal preference is that
multiline statements include brackets, or move the comment above the "if
()", so either:

	/* Disclaim eRCD support given some component register may only be found via CHBCR */
	if (ctx->count > 1)
		dev_info(dev, "Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.");

...or:

	if (ctx->count > 1) {
		/* Disclaim eRCD support given some component register may only be found via CHBCR */
		dev_info(dev, "Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.");
	}

...but don't spin the patch just for that fixup.
