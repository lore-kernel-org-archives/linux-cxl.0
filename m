Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE020BE5E
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1ZTwgQu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FCC187
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 20:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698291845; x=1729827845;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kD5A8hsK+ZVq9c0joOpL1zx/rgn7642qoRDrna1arwM=;
  b=n1ZTwgQuIxmnVihsijR//SgZmsYOPwRoeU3unNJjWpQJ51OCxjy8c6Nh
   PbAhdbH3FJpwY0i0jhJlNq0OzNgWY9CFFBGSvsOYal/43oGlFrrv94ZFH
   1y8Y6cg44pJLfmHim984TdOT0jBqHlWE3VwWUbOJUdZLd/fFamfHm2dFK
   0Sewr2rdEbL3Ocr7TI/c3VLmixc635G+hFEQ9JyJxiuNYm0N4AoXjZ43V
   qLzrEXOwx+aJowCb6WybvxgHbjMYpR2S8ZgMATlKWT50E+Cp6cv5U1I39
   O5LUjoM+HdJNxy+isS2NkBUNv4Jr5ckWiJeHCAcJXJNX4FAscoYxlVaxE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="239830"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="239830"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 20:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="882679983"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="882679983"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 20:44:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 20:44:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 20:44:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 20:44:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 20:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB2J1ASNOLwfKxhtRmxXRCHxqfLoC711cyIDSL5kQq70PoprEpYQPRUJTUwE8Ymwm06RS486pSJjataIuRYh6gkk6xGqVVKoiIrWdXVEpJCSOLA4b1d6aMFD0LeYY5Ze31Xcngfr59V2DfBZVM1jbTwk8LL2amA7MC7R9IXfjx56ff04vZxXwy5KJjYpreL8xkJ02QjAe1KIJqvKPDL8gi4t7aK5iXDjt7IfTDn2qrsD32YuUQaDT6nX0qyAJLOXuyrFNduHooZkL2XQk2ofcljBNaxrx89DYt9g8QPFF4p7Phb6aYxTymI8VmtvDhwY7qAeP8yPPJ7wYwU9MaDrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Cx+vZreq1qYpsPEzPXVOrd51jQQlTybqU4bAVdba3c=;
 b=fDmiew0jo8K+TCjN9nNYcYCID7K/rJ46GQVGnG2QByoSAb9TZQY4bU0gk46DianxXBt4FAK6OK2Cphq2qk92WyvpDOrznxs070PeE/Z2itZbE64ymy4Q6lFWKsYPFdMOZ3D3x5wTycw3wshbdt+H4CbA2Jb+RPPWAH6qRFltF6KYPpRChw4RSuwt4gL2OjrVY26Yl8ai8UKpHx2PNKEsqodWt4scboQQupywNCqLv7ajeer5o7nFZOBTXutv1WAy7MUQh3FD+fnJvCnK36QcBDHekexvMYdlBj37yEHZ8PvKlM+F7W6XsTNPJBoLO1ojTppa3NxZqDouhIw5C8Di9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 03:44:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 03:44:01 +0000
Date: Wed, 25 Oct 2023 20:43:58 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] cxl/region: Calculate a target position in a
 region interleave
Message-ID: <6539e07eab5a5_1894294b9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1698263080.git.alison.schofield@intel.com>
 <0ac32c75cf81dd8b86bf07d70ff139d33c2300bc.1698263080.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0ac32c75cf81dd8b86bf07d70ff139d33c2300bc.1698263080.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: 945b8632-5cb0-4eaf-af07-08dbd5d5ca87
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eqXc8DPT+ZKMbhMWhwFeFJMjFT452OOa8L50yu6ucOfYHJdrLLAQt7YzJ148kg9HOGZWzS9q5wKUHwA4OqNK3joDFGfaD0v/pHYfr/2rZFuoZRTqeretoPzJI14WdblHaY9i9GpYrGfkPopmYERnoet1hNLmCjyeCU9h7PGl7LSM8XRooI4i2gA2EDY+HaOU7nXslKfGIJ6mrLCWDTgRNXUN6F884sScsi9Zml5JEZ7atsu4nTY0oH6zGuQ05QZriEinSOgNnemt0YiBpwFrJ/M8jPxhxKFjV+YUqq0jBwewzTMQw1A94Wademk3ytZxnNQAWta6yX28P5tkAycd9fJb6tDw1UZZRux7xfrSQDmVIuOsUWIXclX07SUX7dA0hdfz5ukr/XLMBPyQozCNkBLjUYuc/JFZtP5ZNlQ1bXg62yx9gLT1FDdLHIHcllE0iJzaYkiWhm9FfxoVs8TPmTxDqpCrbhIcjwgHvjlsiy18RpZTMj6vQzF4GYtSxF7+tbOkGNeV/8tCtdQamCdmINpduEZ8MkkzM1eKB/pEYCQ5bHQDb8rUbMinoAMXdQS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(38100700002)(6506007)(66946007)(5660300002)(316002)(66556008)(110136005)(478600001)(6666004)(41300700001)(6486002)(6512007)(9686003)(83380400001)(82960400001)(66476007)(86362001)(4326008)(8676002)(8936002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nzGBvsKpbm9pyN0vdnx885aGD2ixheGttx6NMMpgEXNdcxsMQkA41BSlDMjH?=
 =?us-ascii?Q?BFV3CcfGnMwI+zBRjHhYGlN/hDT67oTanwLNSVYqoOTZHqHj268YX5QV40wr?=
 =?us-ascii?Q?t8uw65mHPdP56u9Jw7T8E3sCm+0wi2JJA9fOVpILuLc4XueH44HdhrhbIiqZ?=
 =?us-ascii?Q?e4gWW7Z4YGwKYKJ54nDrxiptjEJhjp6sGBilmbtPN21yYtV6LBOS0KS4ChRC?=
 =?us-ascii?Q?NH4J1lTTMRa17qMs2Hf1sBmiq1GeClHLrhnjV/BUT1stfUeFucK3qAsPdS7z?=
 =?us-ascii?Q?Flrh251pelttSWYPC08aacd+3RqY2KWyjcOCoW/f4nQR8JD9BP+GdVN1OM3v?=
 =?us-ascii?Q?TufMUf0XQv7x3O8ASDmlsx4xS/6LonEgonzg9GQ2s9yAQotu9Us/eHDwALAk?=
 =?us-ascii?Q?+Q/Z8WWYv2LUkPdfQdadSpMWYfn5O3GGJ9Z590oj8HV0ZL5kbSY69xgpQxql?=
 =?us-ascii?Q?VbE2Sva4K386GEh2klwov/9Q8fmz7z7BuVyW6v1XOvZJJEozCX1ZDAqRmysW?=
 =?us-ascii?Q?RPH8SbdpE5Nczw7juZbuLRtMSROU5/BpFJ6akYusZmXKbTcKfav7zAwK8sed?=
 =?us-ascii?Q?qek6qBRS+wjs/lMvrERyRrat+8sYeZAB7zOGUGBIdqeABHOz+aXDjT3YZqUm?=
 =?us-ascii?Q?NoGFJ5OtwYt70oc9Kyd3+vn2D4wuI9bhRAPkw6mZUNvykwuLtzipuyXH93mi?=
 =?us-ascii?Q?iBeG5+hYLbfsqrt/wsiTv0aEXcM5Uf6dY3z3LUeZq+uGNVicHdB18pZpOgOw?=
 =?us-ascii?Q?H0v25YOp+qCRs9jy07p3DUhH2hFg3sVI10DTkjkK9jyHJ8qfkXJ3WOivEnMt?=
 =?us-ascii?Q?CDFT9tmOD4oHXlaoKo/4Q70FFSxHoCVo+71duL4sNNgQa2N5YIfr7JSIlSoi?=
 =?us-ascii?Q?IJKaTTazq37yBc8xtuhYe/T1FYjZ60RPwy0CbrAhEcu1re8q1PEahiPqyUbP?=
 =?us-ascii?Q?jzaVXgQYObaD2YJs434HqxImhF/yeCs2ZSrEFlhcXuEVlWr0qsRun+XvjPBx?=
 =?us-ascii?Q?i9jvC92O1FPQhv9r0h63KTvVuHBrBwECeC6fXuidduF5TZa+X6d1lNMZzAeN?=
 =?us-ascii?Q?siZM4l79Lklzr05OPaAKi/iOXBKLPn6Ne0Wv+IAPw74ClIBPtsQanVGFF6on?=
 =?us-ascii?Q?NRG2qnzmOvV9GOe370X0QYJmX+8fIpU1GLOkzUHabpXcp1EDWRARm23rnLLC?=
 =?us-ascii?Q?HMMZ7543y02KehKdgzxp6pheITFzR35C+o9U38SFfyDcm6kldfmTzk/eZ62z?=
 =?us-ascii?Q?1/xaeHsAe/4z9tYgL3uXSUTrZHVthqsiQNXEiFSlAFNUztkXBole96hYIrgg?=
 =?us-ascii?Q?UvARV7PZMk38KvzgsYW+fh/UPyrKWETponKA8kvaXxXmq7K8V8HIBwXsI6I2?=
 =?us-ascii?Q?9Qkk+SrWvBqgyKWBdYoKTo79raQaBV7nCKkFJOHM0R2mdtY1CHToLrdmzOso?=
 =?us-ascii?Q?QrFmhyxJGuom9WI4eMBRi6swuYHAHWg2Qpnop+qGVzFEh3RoxRUmZE4WUyWd?=
 =?us-ascii?Q?7lls56xSOy90OJSuP/WxYL9gg0GpMDwpp8JfBdu1foA/74mGfGSvDudaWqZ5?=
 =?us-ascii?Q?5F7PohqlrXain0Ae1oxmkHCZ8cIJtwPkwg/y8nWrk5rE0ebB1/69KEaZ+np0?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 945b8632-5cb0-4eaf-af07-08dbd5d5ca87
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 03:44:00.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21Y4ut85JeVOqxpY34TyyAiPMq30ned+QC0Myewg9IPs3rSWk+aAEvDsvJqPsWhsAiOKQY+defJ8aTyzZ5TqxjAcUD80defwd+DDrCFJPkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Introduce a calculation to find a target's position in a region
> interleave. Perform a self-test of the calculation on user-defined
> regions.
> 
> The region driver uses the kernel sort() function to put region
> targets in relative order. Positions are assigned based on each
> target's index in that sorted list. That relative sort doesn't
> consider the offset of a port into its parent port which causes
> some auto-discovered regions to fail creation. In one failure case,
> a 2 + 2 config (2 host bridges each with 2 endpoints), the sort
> puts all the targets of one port ahead of another port when they
> were expected to be interleaved.
> 
> In preparation for repairing the autodiscovery region assembly,
> introduce a new method for discovering a target position in the
> region interleave.
> 
> cxl_calc_interleave_pos() adds a method to find the target position by
> ascending from an endpoint to a root decoder. The calculation starts
> with the endpoint's local position and position in the parent port. It
> traverses towards the root decoder and examines both position and ways
> in order to allow the position to be refined all the way to the root
> decoder.
> 
> This calculation: position = position * parent_ways + parent_pos;
> applied iteratively yields the correct position.
> 
> Include a self-test that exercises this new position calculation against
> every successfully configured user-defined region.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
[..]
> +/**
> + * cxl_calc_interleave_pos() - calculate an endpoint position in a region
> + * @cxled: the endpoint decoder
> + *
> + * The endpoint position is calculated by traversing from the endpoint to
> + * the root decoder and iteratively applying this calculation:
> + *	position = position * parent_ways + parent_pos;
> + *
> + * For example, the expected interleave order of the 4-way region shown
> + * below is: mem0, mem2, mem1, mem3
> + *
> + *		  root_port
> + *                 /      \
> + *      host_bridge_0    host_bridge_1
> + *        |    |           |    |
> + *       mem0 mem1        mem2 mem3
> + *
> + * In the example the calculator will iterate twice. The first iteration
> + * uses the mem position in the host-bridge and the ways of the host-
> + * bridge to generate the first, or local, position. The second iteration
> + * uses the host-bridge position in the root_port and the ways of the
> + * root_port to refine the position.
> + *
> + * A trace of the calculation per endpoint looks like this:
> + * mem0:	pos = 0 * 2 + 0		mem2:	pos = 0 * 2 + 0
> + *		pos = 0 * 2 + 0			pos = 0 * 2 + 1
> + *		pos: 0				pos: 1
> + *
> + * mem1:	pos = 0 * 2 + 1		mem3:	pos = 0 * 2 + 1
> + *		pos = 1 * 2 + 0			pos = 1 * 2 + 1
> + *		pos: 2				pos = 3
> + *
> + * Note that while this example is simple, the method applies to more
> + * complex topologies, including those with switches.
> + *
> + * Return: position >= 0 on success
> + *	   -ENXIO on failure
> + */
> +
> +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +{

This needed a minor fixup for the RCD case, since RCDs are directly
integrated into the CXL-root with no intervening ports. I went ahead and
rolled this hunk:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0fee06660c04..62f1feb1781f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1575,8 +1575,12 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *range = &cxled->cxld.hpa_range;
 	int parent_ways = 0, parent_pos = 0, pos = 0;
+	struct cxl_memdev_state = cxlmd->cxlds;
 	int rc;
 
+	if (cxlds->rcd)
+		goto out;
+
 	/* Iterate from endpoint to root_port refining the position */
 	for (iter = port; iter; iter = next_port(iter)) {
 		if (is_cxl_root(iter))
@@ -1589,6 +1593,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		pos = pos * parent_ways + parent_pos;
 	}
 
+out:
 	dev_dbg(&cxlmd->dev,
 		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
 		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
