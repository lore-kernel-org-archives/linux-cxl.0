Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDADC4A3F1A
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515319; cv=fail; b=CuaxHrnjrzGe/Lo6QZaukPiFEVRrGqIna+4Wa2o8lJU6Kf2YgGGdPKZkksDSIjUSIxeP5h+XthIyrCZT6SuSs0dIhDQH5lnOUOda3zHx8shIny6Gqmb0vB4p69T26nUqxKpL9SXa0C5RI6EvsiXXvKqhj5/cU/23QmUR1+uPac8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515319; c=relaxed/simple;
	bh=drjeYPuaoXOp184LO0nGaO96vt5zNpOiFCDn5uH49WM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L6WJYRApD3BKZnBcIAe5bAM07uRdZTA0G3Ta+Rx/iMxt21MulrBxkK4DTBtqpqqTrefEmHOXfQ47i4xstOJMLtqO/1UuCLs9tvTmB4/qdVGD2qSVN21Kvmx5J/w4wAHxCV/ChHh1jFs3y2mbRVGjAbKdM7f4l7aJmC6wV8F7+YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmhURf/q; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmhURf/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789515317; x=1821051317;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=drjeYPuaoXOp184LO0nGaO96vt5zNpOiFCDn5uH49WM=;
  b=ZmhURf/qCZaOyzY5/nrdy0TsboiJcklMeBvk15PPTruS4JE9rMthyf32
   V64ozYtH/2H6aTVnrV6KVTWQtF2lJROXvs4ZjSl+mQpSTiBvEnIdxzc4I
   Cjpkzqr2zTqTMxdWFrykrz5xANQ5SNRIyF/wgTL41KjMr4CuoaFB6usdg
   F83CUSiHv+UTzxRpb9mBNmd6BHr6HzOwBcjmp/izSd3z3eCS3XlI/u5lf
   RDx6mpwelYpOQ82uOhGiNTJ3x1v2BQK9UR+5vmRmynkwItHYhhXmn09sz
   V3l8r7KoNOpiidnXpsFgSGrsUk8IQXWV7kDW8QSfIw67sYOCsBHftTJXo
   g==;
X-CSE-ConnectionGUID: 4dQaBbwuRAWErbqTSce2LA==
X-CSE-MsgGUID: V6rN07GySTGhD72xDvBuIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100215236"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100215236"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:35:16 -0700
X-CSE-ConnectionGUID: sXk7m/oUSWC7fev6PM522Q==
X-CSE-MsgGUID: S+EbOWFxSt6g7Mo7HEAtXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276910711"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:35:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:35:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 16:35:15 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:35:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2vlQxGzMZIAAR20U5gKZBTEHEH9ZY+qu1qmA9mOX7LxM2mfnUcApp1zCUrX8xDD9gsqC9rZi/KCsQGIhuH8iGylOvQwy6H246RGkOi+0cwN5oAXG/4G/N+mXpjLmzq5wvmxohN7w7Lo7ryCMzNBZqgKFAhg6luGxVdcc6x7pleE+9nglBUYHDyxDa6Yvl5P2Upo8EXGeJtNj8saLeL23BGkkWkkJUnEQ2B5lpyDgdhEm+g84VtxVpdY9cGsy6RLTWxEAlk9iLS3lhmxnlJnyoQTg3bR4snF9ra83Hvezjh1m2UTJMt7YjCu9jV0GNzy35iOimeM7eXz9jDykeKdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkmK230nZIJIDCdnCte/pdwOc7ynDxVBXzNzY/TRb10=;
 b=vJvQvGtgIQ8D7d/tXcc+0kjVdIXfZqHKGBSejsB+9FFWr3ymDnQMqgV4lAQnOSmZvPkIQTPhOuFyX4Bo3SzkdczZHgwy9q63+BN9FxYiNwnLqsHCZcKmu+ADii8jN0zYdu7dpeiClYPEofCD7Z0lJa835OhbWgiqd4w98DChuidxd3w09ozbwzkeJxASONxyhWmPnLNQib4SMLiNyAj/RPnT0Mgt9tZDGAbIz8qzUZMUovWixw7yg2ORZ3X1waNNmpkz/k8oKvgRROLHMWLlzFkN9MFzQQYFWiRZF4iVwkFWuWIh2r04fCyUIdC1RDoZeEONt+5rgZeWW06clIUSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 23:35:12 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 23:35:12 +0000
Date: Tue, 15 Sep 2026 16:35:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>, Jonathan Cameron <jic23@kernel.org>
CC: <sashiko-reviews@lists.linux.dev>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Message-ID: <aqnWLH-nrXk6BYqM@aschofie-mobl2.lan>
References: <cover.1783795720.git.alison.schofield@intel.com>
 <9a798f6b445ca8f2b16743d3e16fa289efadd86a.1783795720.git.alison.schofield@intel.com>
 <20260711201508.082531F000E9@smtp.kernel.org>
 <alL3a2UXB38XI7Nb@aschofie-mobl2.lan>
 <alXqISpyXQVzOlmq@MWDK4CY14F>
 <20260908000455.32884adc@jic23-huawei>
 <aqjSLWq9-uFwdhXE@MWDK4CY14F>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqjSLWq9-uFwdhXE@MWDK4CY14F>
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: e88ea657-304e-46d4-9d73-08df1381fc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|4143699003|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3N2I/F/2S0RxSTDRxehE14da3aPk38e5W/MaV9bhkp/AfIjYoKAK/inCu7iLG4ONHOE2qpEdzSiS1IOb3GGjwLD2d1OBW9xaNvjyi+6aOwf9xdNubiO2HvIwdo4/L2kHnHMx3hj4S7uvH8YvcbDD0EIAA0p25aP9/ln/hg6VLZLjB+Tky0Mdn8qDj1tgtuIfVnnqUDEWldyLByOH7ffC/xAKexL4OQXjuzJHu1jbw6OBWglZpShZLQxYyOJ6zYidrdUBIE7LBulSEKdB5abUm2YJ+Yu+w8S7vHXrr4CFYBDb9gJtN1y6sY+IWrRB2RH+KHgzyl3GXGNrifTkxv9CFRkuplojzo8Huva95QDouYD07fd5BDu7hm354NNFTgLMwKaQFBPbiQZLo8Bdhshu7zOMPg+fjBeHXEo58ruUyKzfXnUrTVXWGnw5HAlCKgqZT47r5ewp3rXpCZa4M2hGtQZSr/wmUgZyzj5jLWgIViccOzYHC/naNy2pzNBUyVPI8vMWOyIcI77SPHztwcZyedmaJ5IemXDJHbyqCKE2wqlpcn2+roOWfLDU8K/e2+ehuMhBMdvGoKtd/Gj7x+LLLlSlZ4OkPQCERLkO1Ixv3lI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(4143699003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VVYkIHdxr9dbjHDljro27GPGtN15/02o27dapaIMVJUuyBMiGx5iqRohB4?=
 =?iso-8859-1?Q?33hWePtK+Lo6Gz9Wn3uuCSDrHaORt8UYNTbwKYHb3gPEY2KwauzvbFl0Wi?=
 =?iso-8859-1?Q?vJJX5zJIiikouZ7kViNRd3PeMoDgNyrqMj/RJdS/45Dxy961eWrnyoEx80?=
 =?iso-8859-1?Q?s7AvNkqEYMsGvja0ky7MjmrtJqa8j9VFfMJDBa6bOcLltzjWFQErKk4gvb?=
 =?iso-8859-1?Q?139KABu0r5ojhlGfkEXP6bEcnEfFKvQTiAddOyHPTdXoDvDOCFtBdYp4ej?=
 =?iso-8859-1?Q?1n36yirINKTBxM88sE0Y7Umy1BL6NwtthIhlPuyuTo9Zu1Z+P2VScKbWge?=
 =?iso-8859-1?Q?OOf+JarAmmOrvhd1LB2ceG6DNONHiSbR47IYuLyG6j2QD4yub//HyhEhw/?=
 =?iso-8859-1?Q?tFPq1yhGD2JstNJRGz4DBWRvPmT5izBZm/laW1eJffLSpmz/MvDm5h7Yf0?=
 =?iso-8859-1?Q?JWVjDwXFem0a6wcXHg921a6cqsGuCvkvXDkBckgMk/oerz4U7tUED9snxZ?=
 =?iso-8859-1?Q?tNRW4583pjq3sSrulCjmbP/ITT1V+fh3XEpUmpdHOfQ0fl+AH8KbNz3gRa?=
 =?iso-8859-1?Q?Ika9bVAMnN2z46NJP3RWPXFdms8PEt8ieAbt7xBzs5yrVEr11QJHCe7C9/?=
 =?iso-8859-1?Q?0i0RieL6ek7cCvfE9yCzeBJRhXEvgUGbqg3HsDl9aHtppbyVzh7SusQAoa?=
 =?iso-8859-1?Q?0v0xzSdwMrh2ZZiZAsyKxgDcViuFF39qJlPNOfr+om1XEwntur5RC2OHb7?=
 =?iso-8859-1?Q?L8wwPfzV93bAAu80rV+LKN0aoecsNiJReNgFTRzvmz0h/g46fOIEDp0Wrx?=
 =?iso-8859-1?Q?mY+fKBQ7LvEzbsCvq+Vwz3BYRW0eAFeQiknmfJKnXi9mzn+KTjSqohA7PO?=
 =?iso-8859-1?Q?HW+YdDenGUdIJD1fHdCOYr/b1sqayffxx9z8EbAvpvAO9tETnAamR1MTH0?=
 =?iso-8859-1?Q?KeVXPHiI24NV5L531BqE3RLX2P0IEmmALdo1UU04CSq2tzAfj9bC82dJ5G?=
 =?iso-8859-1?Q?BVb4jElMVLgyFD6EGsNny5jOZKHesrAOJzoE+2SUrz7JGlk/sTIYD3V88I?=
 =?iso-8859-1?Q?8g+Ky+dDwJ1az0TGH7SqD6eYoiudDp3dQS0Jf/HzJsFdX6rzSlb+ffFF9g?=
 =?iso-8859-1?Q?JeEok7eQerbFBbsMY4xG2WOzwGxuTip+1sXCrl3PDmBVQELLloZsTq39Vm?=
 =?iso-8859-1?Q?hjAZaNooI6agB9Qlmwul055I64BD6pn/ivOXieKqacyTgxIyAsVq1pFVYa?=
 =?iso-8859-1?Q?2/1WuXczUftEj2Eq08FElyfGZXtJqyVDuaHEKSJ25Bo4g8O6h6bZayybfB?=
 =?iso-8859-1?Q?LchI7y0CVO2bTN0f0YO///pbZZ9XwR0oqJn4opEl3nC7KtmtyMxZllC5x/?=
 =?iso-8859-1?Q?sG6TmGgZl8Fc3U5uEJrSxVEu7DvuOxXySH93PXT14HY9tfe8wC2BI99lsA?=
 =?iso-8859-1?Q?NFQ/YMqe21fEn9W0OTN+Bv5TgEgfxB9xzf5mVtR6U2nEk83gYegbI14CYD?=
 =?iso-8859-1?Q?Dbojiy6d2HZfX3n9jFBfQNSAevP0ffhkn4NtaFZ2ZtfVU0ibrOqRuEoaN2?=
 =?iso-8859-1?Q?QBqAKGfvXb6JWUp4S1O3vQYUrhtp4mHGyz8gxHFm724E1ReHwnMUXwp9/E?=
 =?iso-8859-1?Q?enhPb2Ie6XgCv2MpSqykV50DBaH0sE30xf5nbC7axDxsXp12sGIPNaudsC?=
 =?iso-8859-1?Q?3OISA6SlHyF7gE/kvzHnFvSVMEyDBi2hi52P3F326ODRs4kb4UZI8oddfx?=
 =?iso-8859-1?Q?VIwo0tFGxjPXUBzWyUh6ESF6hl3WAwt5gUIobqQXkG7gs6f6jg2D9ZxvNK?=
 =?iso-8859-1?Q?X9vJK/Pk+wMU9SqfQqvcIgQ1/PQ2bu8=3D?=
X-Exchange-RoutingPolicyChecked: 5agksCZXik3gtlCbgSw0rssHgw28tCW9ml+36AeBFeqz1+VJ8DiKwhiTWzZY1F3+H3Mou0XmU2nw0ZU+n+JEl7BDvN0uOEPegRfQErBZqlkqzy7FvTkKU/5qlr4WW1/Iq6IlI9X0PM8qlFTH30eZwFddePdJXEU28NBrAPezZNdqxC74B/e+BT/E3+aD5O7keAsBIEP1rN44LkO4r7kTl6+8yD+yPM5Rx9GebLG6FibrNKPUdHpdqU1PoosTNMsGcr1/wIYpzHG9T/kPuYnR5KccnZBHkt2zoo6owQ/KDcAXOELrxrrMPJOxL4YgPSfHDJic/ro3yUWON6mHt7Z6Ig==
X-MS-Exchange-CrossTenant-Network-Message-Id: e88ea657-304e-46d4-9d73-08df1381fc8a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 23:35:12.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m0+7VDqKVZ36OloiVKsfIo9hJTDPsWvzS9P8fTCv8/nx6O6uYx3X1AqxvprDqdDRM6844gM2KJk1aoeqBEFuU4GxzACRUPfw+agYnm5V2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7566
X-OriginatorOrg: intel.com

On Tue, Sep 15, 2026 at 01:12:46PM +0800, Richard Cheng wrote:
> On Tue, Sep 08, 2026 at 12:04:55AM +0800, Jonathan Cameron wrote:
> > On Tue, 14 Jul 2026 15:56:18 +0800
> > Richard Cheng <icheng@nvidia.com> wrote:
> > 
> > > On Sat, Jul 11, 2026 at 07:09:47PM +0800, Alison Schofield wrote:
> > > > On Sat, Jul 11, 2026 at 08:15:07PM +0000, sashiko-bot@kernel.org wrote:  
> > > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > > - [High] During auto-discovery (CXL_REGION_F_AUTO), passthrough decoders fail to update their `interleave_granularity` software state to the computed value, causing downstream decoders to inherit incorrect granularity and fail validation upon reboot.  
> > > > 
> > > > Same NO as in v1[1]  and I don't see a way to graciously alert you to this
> > > > in the code. Gratuitously updating the field is not the right thing to
> > > > do.
> > > > 
> > > > 
> > > > [1] https://lore.kernel.org/linux-cxl/alKP8OP4DNT2nJnu@aschofie-mobl2.lan/#r
> > > > No. A downstream decoder can't inherit an unecodable value into a failing
> > > > check. A >16K granularity only appears below a wide interleave, and
> > > > everything below that inherits an equal-or-larger value that an interleaving
> > > > decoder couldn't encode. So every descendant is necessarily passthrough and
> > > > never validates granularity. There is no path where updating the F_AUTO
> > > > value would prevent a failure because the failure cannot happen.
> > > >  
> > > 
> > > Hi Alison,
> > > 
> > > I'm thinking of 1 scenario where a regression might still happen,
> > > independent of whether an interleaving decoder can appear below a >16k
> > > passthrough decoder.
> > > 
> > > The new cxld_set_interleave() behavior writes EIG=0 for every IW=1 decoder,
> > > including cases where logical granularity is encodable.
> > > 
> > > For example,
> > > root: IW=2, IG=4k
> > > passthrough: IW=1, logical IG=8K
> > > downstream: IW=2, IG=8K
> > > 
> > > During manual setup, the passthrough decoder gets a logical IG of 8K.
> > > With your change, committing it writes EIG=0. On rediscovery, that is
> > > read back as 256 byte.
> > > 
> > > The AUTO path accepts the passthrough decoder because it skips the IG
> > > comparison for IW=1, but it does not restore.
> > > 
> > > The downstream decoder will inherits 256 bytes instead of 8K and its 8K config
> > > fails validation.
> > 
> > I was looking back having seen some text on this in v4 that confused me.
> > 
> > Isn't a failure on this combination a bug anyway (that we should fix)? 
> > The downstream decoder shouldn't inherit a value of granularity from a
> > pass through decoder (as it's meaningless) it should be getting the
> > appropriate values from next level up in the tree (or further if
> > there are more passthrough decoders up there).
> > 
> > Jonathan
> >
> 
> Hi Jonathan,
> 
> I think you're right, one problem I'm not sure about is that whether
> a passthrough decoder will stay as is for the whole runtime ?
> 
> Since we're assuming its register will be ignored with IW=1, it makes
> sense to me if that's the case for the whole runtime.
> 
> But if IW at somepoint becomes larger than 1, not sure if it's possible
> in any scenario, without the correct bookkeeping we can corrupt the topology.
> 
> Maybe carrying the effective IG/IW through the walk would be better ?
> 
> Best regards,
> Richard Cheng.
> 

Replying here to this v2 because this is where we have the most matching
thread, however, for other readers, the set is at v4 now. (Not to worry
though, because the next rework may blow all of that away ;))


Jonathan, Richard,

I think I understand the concern now, and it looks like the >16K failure
exposed a pre-existing problem rather than requiring special handling for
large passthrough granularity.

I reproduced the existing AUTO problem using cxl_test by changing the IG
of a passthrough HB from 4K to 256, modeling what's described in:
ce32b0c9c522 cxl: core/region - ignore interleave granularity when ways=1.
There is a 2-way@4K switch below it.

AUTO accepts the 256 because the host bridge is passthrough. The walk
computes the correct 4K for that level, but discards it. At the switch
below, it reads the host bridge IG back as 256 and expects the switch IG to
be 256. The switch is correctly programmed with 4K, so AUTO fails.

The non-AUTO path works because it stores the computed value in the
passthrough decoder. So the underlying problem appears to be using the
decoder object to persist the effective interleave state through the walk.
That works for an interleaving decoder, but not for a passthrough decoder
whose IG is don't-care.

Following Richard's suggestion, I'm looking at carrying the effective
IG/IW in the region refs instead. An interleaving level would consume and
update that state, and an IW=1 level would carry it through unchanged.

If that's the right model, there is nothing special needed to support >16K.
A 2-way@16K root followed by passthrough decoders simply carries (16K, 2)
through those levels. No 32K decoder IG is created. If a later decoder
actually interleaves, it computes 32K there and correctly fails validation.

One remaining question is what interleave_granularity should report for an
IW=1 decoder. Jonathan, I think your suggestion was to report the effective
IG carried from the last interleaving level. ie. with a 2-way@4K root followed
by a 2-way@8K HB and then a passthrough switch, that switch would report 8K.
The alternative is to leave its hardware don't-care IG untouched once the walk
no longer depends on it.

Direction check please and thank-you!


-- Alison


> 
>  
> > > 
> > > Could cxld_set_interleave() keep the real IG encoding when it's encodable and
> > > use EIG=0 only when an IW=1 value isn't encodable?
> > > For latter case, AUTO still need to restore the computed logical IG before
> > > walking descendants.
> > > 
> > > What do you think ?
> > > 
> > > Best regards,
> > > Richard Cheng.
> > > > 
> > > >   
> > > > > --
> > > > > 
> > > > > --- Patch [1]: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K granularity ---
> > > > > commit 9e2526342188a97e338bfc63d454c253f1e2b3ef
> > > > > Author: Alison Schofield <alison.schofield@intel.com>
> > > > > 
> > > > > cxl/region: Allow passthrough decoders with >16K granularity
> > > > > 
> > > > > This commit allows passthrough decoders beneath wide parent interleaves
> > > > > to have a granularity exceeding 16K by programming a don't-care value
> > > > > in hardware for non-interleaving decoders.
> > > > >   
> > > > > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > > > > index 0c80b76a5f9b4..d164662668c19 100644
> > > > > > --- a/drivers/cxl/core/hdm.c
> > > > > > +++ b/drivers/cxl/core/hdm.c
> > > > > > @@ -691,9 +691,16 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> > > > > >  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> > > > > >  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> > > > > >  		return;
> > > > > > -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > > > > > -		      "invalid interleave_granularity: %d\n",
> > > > > > -		      cxld->interleave_granularity))
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * A non-interleaving decoder ignores the IG field. Encode a
> > > > > > +	 * don't-care value instead of validating the stored granularity.
> > > > > > +	 */
> > > > > > +	if (cxld->interleave_ways == 1)
> > > > > > +		eig = 0;
> > > > > > +	else if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > > > > > +			   "invalid interleave_granularity: %d\n",
> > > > > > +			   cxld->interleave_granularity))
> > > > > >  		return;
> > > > > >  
> > > > > >  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);  
> > > > > 
> > > > > [ ... ]
> > > > >   
> > > > > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > > > > index 1e211542b6b64..5a443551288c4 100644
> > > > > > --- a/drivers/cxl/core/region.c
> > > > > > +++ b/drivers/cxl/core/region.c  
> > > > > 
> > > > > [ ... ]
> > > > >   
> > > > > > @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> > > > > >  	 * Interleave granularity is a multiple of @parent_port granularity.
> > > > > >  	 * Multiplier is the parent port interleave ways.
> > > > > >  	 */
> > > > > > -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > > > > > -	if (rc) {
> > > > > > -		dev_dbg(&cxlr->dev,
> > > > > > -			"%s: invalid granularity calculation (%d * %d)\n",
> > > > > > -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > > > > > -		return rc;
> > > > > > -	}
> > > > > > +	ig = parent_ig * parent_iw;
> > > > > >  
> > > > > > -	rc = eig_to_granularity(eig, &ig);
> > > > > > -	if (rc) {
> > > > > > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > > > > > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > > > > > -			256 << eig);
> > > > > > -		return rc;
> > > > > > +	/*
> > > > > > +	 * Keep the computed granularity for descendant setup. Only
> > > > > > +	 * interleaving decoders require an encodable granularity.
> > > > > > +	 */
> > > > > > +	if (iw > 1) {
> > > > > > +		rc = granularity_to_eig(ig, &eig);
> > > > > > +		if (rc) {
> > > > > > +			dev_dbg(&cxlr->dev,
> > > > > > +				"%s: invalid granularity calculation (%d * %d)\n",
> > > > > > +				dev_name(&parent_port->dev), parent_ig,
> > > > > > +				parent_iw);
> > > > > > +			return rc;
> > > > > > +		}
> > > > > >  	}
> > > > > >  
> > > > > >  	if (iw > 8 || iw > cxlsd->nr_targets) {  
> > > > > 
> > > > > [Severity: High]
> > > > > Does this code break region auto-discovery on reboot for topologies
> > > > > containing a passthrough decoder?
> > > > > 
> > > > > When cxld_set_interleave() configures a passthrough decoder, it now sets
> > > > > eig = 0 (a don't-care value) in the hardware.
> > > > > 
> > > > > Upon reboot, reading this hardware state will initialize the decoder's
> > > > > software interleave_granularity to a stale value.
> > > > > 
> > > > > During auto-discovery in cxl_port_setup_targets(), the CXL_REGION_F_AUTO
> > > > > path skips validating the granularity for passthrough decoders (iw == 1),
> > > > > but it appears to be missing an update to correct the software state:
> > > > > 
> > > > > 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > > > > 		if (cxld->interleave_ways != iw ||
> > > > > 		    (iw > 1 && cxld->interleave_granularity != ig) ||
> > > > > 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> > > > > 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> > > > > 			...
> > > > > 			return -ENXIO;
> > > > > 		}
> > > > > 		/* missing update: cxld->interleave_granularity = ig; */
> > > > > 	}
> > > > > 
> > > > > If cxld->interleave_granularity is not updated to the computed ig here, won't
> > > > > any interleaving descendants read the stale parent_ig, compute a mismatched
> > > > > expected granularity, and fail validation?
> > > > > 
> > > > > -- 
> > > > > Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783795720.git.alison.schofield@intel.com?part=1  
> > > >   
> > 
