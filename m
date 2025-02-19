Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D652580ED;
	Wed, 19 Feb 2025 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002745; cv=fail; b=jTNkSrQWZr+6dxnTS/78BfEl49TdouiSiG9IPKuZAa3Io5owhmOE8nn9X3pWDrhJQ4+kfP9yd+Wpl/iSGIg/ns/M56RZmQcQFinpvSdoFHpoOCrwvDJYIpXjeVD3P6n6cEG4uYqJcgIFHZwQPu8A2fLiT+TaW2ye5t+65eVT6q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002745; c=relaxed/simple;
	bh=4O1a+f4InP7pkSSrf06iruxpzLpZQJyLmdU9fY46p/4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B3nHJnkBs/5eOoMysTzp9SXL7OauCgflJETs/H2vrwRxEEUO6CcnAPaW5qYhzds7GN2OcH7HVQlKpWYRUfQSRG2FK/UVLrznfI3F9oSgiuCRUmGvKewv1MqzWr1iiNiBO7qZ2KBV6TyciosbXBqHT82e+QU7O5F7xD8z5GaXQuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MyOHiXHs; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MyOHiXHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740002743; x=1771538743;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4O1a+f4InP7pkSSrf06iruxpzLpZQJyLmdU9fY46p/4=;
  b=MyOHiXHsWLylfyEYu+uBYI0ocT9ggrFCXthxngq3Y7CqYNz183+VLW4l
   OBpe67XypWKmqA4FEcZ+0MEZ21XqpudN3d4EzsXIUSnAo5xgHNonhZwoR
   da9h/SfkCY4RFKaMESzTjhpRGn6oXnyIelN4pKEqvQRaQqwHi+h21ne4/
   G+BgtnrUZ8BVbNgVp2bJ3WLccFmYL19uIYMNogM2NWBo3R8RtXsaV9S9k
   rOLTE1uK0sJE2AlQtXfh4FVkzJRG4WwKbQxHeF5FYUuwam8NBqHqetOP/
   7nqWtsinQkK/VHXybwRpZB97zgzpr8KkVkN1bdclih2jmcVzoo6yGoM0y
   w==;
X-CSE-ConnectionGUID: K1GX1FnDS6e/ViUtUCy3TQ==
X-CSE-MsgGUID: QKO0X9KUSumH4Q7oPHp3Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="50975230"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="50975230"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:05:41 -0800
X-CSE-ConnectionGUID: l2PKP/FBSeylrh5et8RX6Q==
X-CSE-MsgGUID: 2YYAdAK4QlyLM6mmuBP53g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119462205"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 13:22:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 13:22:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 13:22:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 13:21:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghhIp1+4bVcivwxhme4EfEexmD940xhAycvWWRM3SfBmOAg8H+C40vcIfsGh6a8B4+j83U/NJBKyqILGq7PNZMkB72cehxZ8ZVj37DAW2rMy7vJl7feGA/ztJPxAX/2T8JFj95b+qnfproy47jiG03Wx1LKER6h0VHwDJ3vsfmWuxDbEFMveFdi7W7XIpr5MzTlWZmTnFdVFLgX3pvs/aOrvkCl2QmCC7XV0mrNaSB9uCemKvhSGzHT9fVRxeZ4z2R5V9dPFIpPLCt1MaLKgr15JuWif+Y/V29m+Dr2S+P1LoHhnac5lxw0NFsc45vUXz0t5RVwXxvUTVA48Z2dLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmxCVcmFSOEY0qMoiw7DBmb8VKO2D9hG1+IpfY51h2k=;
 b=nGTjABDxq5/BQ2DTJ6ZVYIqPO6q1wahzLX2eIR+9AAJdNy34TNM9TeLeGibirht5WD60V6rmhzgE7/lT+QuLBiucVdbhMIT3nOf+fqDr0uPFaOY2z1RmiH5PQp0X+gHuaGIvgBhYgQ1WKWGi8svIMR/ZDXO0tIR2yaxkcZehlIKJ2BsSQlk+z1txoJXSAF9C4DOmo/E/xFtjXkowZKusuI1xrPvREDT6LeNbsJH0DcSgAMtUQomn8yzlntm1zF5wvmnysT9KNXldgTIpzwOhU2rpGhXmI3/26spDqPUvphaabG/nEWZeiHh+qjQhyVXmrho7CDEk8cF1NiQfSVvSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5284.namprd11.prod.outlook.com (2603:10b6:610:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 21:20:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:20:56 +0000
Date: Wed, 19 Feb 2025 15:20:52 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenbaozi@phytium.com.cn>, Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: Re: [PATCH v5 1/1] cxl/pmem: debug invalid serial number data
Message-ID: <67b64b347020a_2cf2f8294b4@iweiny-mobl.notmuch>
References: <20250219040029.515451-1-wangyuquan1236@phytium.com.cn>
 <20250219040029.515451-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250219040029.515451-2-wangyuquan1236@phytium.com.cn>
X-ClientProxiedBy: MW4PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:303:dc::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: 787c3d2e-c10b-43d5-e0f5-08dd512b4c1d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PjKcznLjwMQZBaCKu24zy0Na/j/IHa28QL8mrl7vP+ccY3jXFYQ61zEHMA/4?=
 =?us-ascii?Q?R0PkGy6sXS8HukKOJ5QTJmCaD+476BFqPMqN83DiJ1yqnJTltqD7K+Ns72VZ?=
 =?us-ascii?Q?154BnVFIYEClt3u5wlxX/Aq97p1/DTUMsHO65jJpZwbsDgBN3ZFSI2qQi9Tf?=
 =?us-ascii?Q?0kUCgrDsW4diP6oANNi0axeDQC6ufOff0nknWc4S6f5++qB6C/DIgyb/yLQV?=
 =?us-ascii?Q?TWDR0k/BF3Szb6+pLfEgNGE/N4IN92fWJq5l9Yi5BdZx1ovXseHI4cAE0VD6?=
 =?us-ascii?Q?Co4rP4leWevG7NZ1C9QfzOW90W+MW03BRJF9S8rUfEeyloZzsjhu2fnIgf+A?=
 =?us-ascii?Q?ECuhJaxwHy+HiV7matGleF9bI5UIlxP4T4+PtQNbDtt4IJ4VbWXBu8Yw05Bi?=
 =?us-ascii?Q?1Nl7XjWeMtATM+EflELL/r5H7tbNtsaQVyazLnAmXV0SlEmk51+224IpNjDc?=
 =?us-ascii?Q?EaB48Ns7Gnh5lcOfYrgB7nrRkzjxN8jbwz+mMRneLpfVY/pG5ILUpM/BKCOt?=
 =?us-ascii?Q?g6Rhj7vmu52IACSkdR6WdMbBOn5pnrNLewVnalDxMCr2K4UySnbDmBnVvlGJ?=
 =?us-ascii?Q?U93a5t58ToFTgCcgb+SdrwkVAP/00WRgQlYpzXMPyumG7lak2lR5Qziq+ENc?=
 =?us-ascii?Q?OqSnI42CNf8YN3hLjrERPS2xeA1BpJvt9RyL/1CM4c+7pBfPuIyCJmSQPK8Y?=
 =?us-ascii?Q?4MtpOjKiW6Sf9uFUIGePFhXXjpbmgBEN21k42wfny457iPey6yHxr0XjlD+i?=
 =?us-ascii?Q?OoGWNDN5PAMOdam09XBBtoLU+PL+PmkOQjsKr4ZcOV5pF2LY3AjDGAcO4J3K?=
 =?us-ascii?Q?gdyS67yHv6F8w/BvSPZL7/eS5DMpI+TCMglq8+c0YhBlGZw4iS2Dw3O6aif2?=
 =?us-ascii?Q?VhVxfKdEyQstWa2PeJ/VQVSIDjISu/ZN2RC+6V4Or/4e+j5prrWzX8UpbvJd?=
 =?us-ascii?Q?vdmLrHS7+GMdGg1fcMcrbp7XUD+1fVfd0sisv1NxTo0gGeAv/7yTGLO5Pmuo?=
 =?us-ascii?Q?wSevuEvhfcQLDUH/TVXLsY8+A7rssFcqYn4ChCpx8+JrEUtK6JvO9apvPNJz?=
 =?us-ascii?Q?/fjIYplrMv39Krh9C/PP/9toTImJ6L2szGoT6KBGzZBKyPf4PuRwMuDeiRZ7?=
 =?us-ascii?Q?NvbqIMUpSKV1C5Bv0zdz7+s2CaAF1xsVrSfWqyweousH5bfaNoRRGtpSfXQf?=
 =?us-ascii?Q?UplOtrTELH64Hmk1HW7SRRyY28lxzwl4EEnR65ALeXE+A/FVdMfWbkPhG9TU?=
 =?us-ascii?Q?zddyYbYbjNKH+JYbnR7DyBLD7wqnxlA13+ItNLDbTk1hgLUdX4NJlV+sgJJW?=
 =?us-ascii?Q?ijc9vFL+1Ort+OECEGgVeZy4HRIiirXVk7gWqoZPHQI//A/FnOdg0sQBldHw?=
 =?us-ascii?Q?eMrSJ/rr67QvHaHzVzT9jHRf4YVq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4uQPvRIuJwZLyOrizUE2eWDrssmFM3Xe9pMr6EOr49C7yZ5CXM3Db1wbaJeU?=
 =?us-ascii?Q?b556+2z4JKvhR6t2eY9rBMxrSZoqEd09zoEhWxPJM/ovIYXLrmizIexY+2J+?=
 =?us-ascii?Q?ccYfqsMwWDlpx9VCgulj28Jb2PlsmH+hKuGIHXr0wXlBXzV1JS6xFRju2vbK?=
 =?us-ascii?Q?oImEUkXBs+zYkgVaHSRGB+1gi4AvYYr0pAq1NRpbZu9s4bkmmmva6h8VUBpE?=
 =?us-ascii?Q?xwvH73qkKiq25uf7/MVm9rsH/F+Dq9yfgEjGB67daZa+cW0zIUw5XH57IvMV?=
 =?us-ascii?Q?I/AblCoBO4BS5yKEtOWgAxmnF9u43WeYaLQgcxq2kjYIIdgpeFTByT0eyCKc?=
 =?us-ascii?Q?BrAxHNjgS8mRbQHyQWYfRYYNlquTGivGltvPhspqqivC/EPEIF7dN8z54SWu?=
 =?us-ascii?Q?3ZCdjP7Ej7zYuWRitCxUVxekEXMhCMhfUXMmsFXmPT+oVsEZpn3hAj2guxH+?=
 =?us-ascii?Q?94I8eB6i9cGaP6EGl82BSSXTsK/5WoblskTBhPMi/Rs8rQwyTFRpbaUqraRX?=
 =?us-ascii?Q?BibKw+tZdRCcEtd5Zr1AS6jpfxW9DeXWk8Xh++TISdi4ENzG7QzgdeYruIjo?=
 =?us-ascii?Q?z9DLcoVaw3BOpRypv75WeVNwOOeNOrlZ3xdHeZp2wLh2KK531jwbIXSy/XR+?=
 =?us-ascii?Q?N9KSWz00fdyv4mTH9leMBlej1tHirPGrYqxao/I6GUGlvkJ2PcSApbX/7zFV?=
 =?us-ascii?Q?NQ4isH3burq1MSknAzYskyhUJ+BaV6HdluFtsJSIgR18xb/IQyuv6DERK+fP?=
 =?us-ascii?Q?PueSf35+eErTS2Bi8Y6/v5MC9JWid/qEhYBEMuiGCFBK8yEKSCI0rPN8KK+a?=
 =?us-ascii?Q?oLOoxoaTICklsNu7k6n+cfqqMI1E8H7l22Bh7S0qWQOeIShEK0CwXblOibXr?=
 =?us-ascii?Q?FNUOL8U6ZT4aWfrjznzwWvRFW25R0uq0DS7MO95b/nNhnOGcv1Or/fjoWdc0?=
 =?us-ascii?Q?mg0gss0ZGAZjkiDMjPIs9TZ/qyaAEOao2wAAiBJiuX6J8OJ76ZrQb3Uj8IWN?=
 =?us-ascii?Q?I8j+c9wIKCtpGz7+mju4BX0v/9T+EHyRXMkK7RIrJQYER3f0rIAUDG691sm+?=
 =?us-ascii?Q?0Mptpqp6WWf3TPQKOJStIkrv1vo8E1fz8Sf+8UKdOvGFDY3jQ9dPpS/ctgik?=
 =?us-ascii?Q?IJdW1d/S1Wc2OeKCEl4p/+jrdchgDH75hCYRN53Wt78JGJQhtaVRzcVWxc/4?=
 =?us-ascii?Q?yEMhzKfeborwEzwUttcXiKbJp4LWo3f9+QdfmAns3Yk1JTKun781S/ApLS81?=
 =?us-ascii?Q?1rJiFQZ+BeVy86qHUPQdbANZSpK+hIFi6+hSAiRq+E7cG7WHoBrRHOzumWyY?=
 =?us-ascii?Q?GQzVQbnVyY6TqRV0jCTBFLyKKDHmhwRD4iQ9nuWL9oeNilHeORBBItWoxplq?=
 =?us-ascii?Q?VrGKULGrhGaht4DSavl7MWR8wFk+mNlrbEAIllEA+hixHJdSSYlZscRZb+xi?=
 =?us-ascii?Q?h2Iv7wWUVmQAputy7Rh6qWL6T6juH2vwYCm5Usu4QnOEeFNsaC2HoCVANJe8?=
 =?us-ascii?Q?Z3XEZ1puxlNmJCuFitPw9QwOD1zBsw1w1heq7hYrp25YK3Q+UxcrKVP082iX?=
 =?us-ascii?Q?w5VpR32rOp/tdVoRv33nb3I0x7jFNqEvtvtAeEZo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 787c3d2e-c10b-43d5-e0f5-08dd512b4c1d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:20:56.0478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArvvSd77U5V+eEkNOfDhdcDHLiZNwrwh/Xm0E2LzB3Puzm4s81BDhgTpPl2iwXlhQsWg6VBjypIAEdvVead/Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5284
X-OriginatorOrg: intel.com

Yuquan Wang wrote:
> In a nvdimm interleave-set each device with an invalid or zero
> serial number may cause pmem region initialization to fail, but in
> cxl case such device could still set cookies of nd_interleave_set
> and create a nvdimm pmem region.
> 
> This adds the validation of serial number in cxl pmem region creation.
> The event of no serial number would cause to fail to set the cookie
> and pmem region.
> 
> For cxl-test to work properly, always +1 on mock device's serial
> number.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Seems good.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
