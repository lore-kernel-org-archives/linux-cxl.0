Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D361DA50
	for <linux-cxl@vger.kernel.org>; Fri, 20 Oct 2023 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2xFEFgR"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2986C0
	for <linux-cxl@vger.kernel.org>; Fri, 20 Oct 2023 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697834308; x=1729370308;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GPeGjr7Q3whi4KXF0YJdtwrn5uh19q6G71eoo4RaxXw=;
  b=g2xFEFgR8kJpcmxqhL3R3dUhHC/vHSjb56udugQMKnUwXyPgkXnZTU6L
   8GqiPboWQcXNeCx9WxJvY1OuzGMj5352hJ45mz+HaGYQg5phbXqByPuwH
   /1MmprAANsFuukOAbH/23D42ODjTfuhhtE60qmWudMZNKaHm1pdouklv5
   y8s8s+KoJL718omtPr4aSe8elupWpTGFziW5l0DetAtMOxV7DjBxcuF0Q
   ZNaTo7Oxt7Hd/1mbP0pAM3n3FDZEYlucGupY7Vq3Sz8OGYLzNayppdT6H
   bYjSVemZjCFgIfUxC+Gn/tJD9LMjeDkA4TMDVwqle2rfXSOvkrTZoufL0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="390458645"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="390458645"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 13:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="823375491"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="823375491"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 13:38:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 13:38:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 13:38:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 13:38:27 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 13:38:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfbhUM5FRMjfIMpEREOubLixVg/BIYZpr5oXQwcGJHoiQ1QdJDTQgeKT8bZ+ZytQtZ9nLqJLEAVikHY7dOT9V6gh7LNcT7B6TaNwrB/w7PVwzuCt8LsDMVTEw8sGFL4ir7WsOl3CPNjLoxHBHdKQvXqCIrL7gTYvIvU+eVUV6B7sG3RjxcrMpjR4hiL3Xr8GdF2xNtQxJj6YxgqNyOnwOQ14e5zqB74YHI7QSIXmb+Moa4SU0uR9AhPKkroLgD4mSc+wJgkP79ksoKPT3CVHZP0PLJdvW/zo+VVrTDd1EZhn/k+cq5QlS32XqKOn/dZq600kFe1uHSqPmC2iJKInZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu+y9NuqAhcpONFnTHTc+dNlf+f10LbPxLFVwFIAZSk=;
 b=n4IxEOwq1AqHTV04Tuifd9OzXNvt9mPPnYw4EbXCcecrZ4VpCrPIdNwzGYyV99Mk2Xoz6zpXM63YgBlmHzJ+rK69occU2XBM7/D9LopqLIDTvIGxbxg7ICeQPX8vmnlKHN7yp2XyDcdnVq1GDR88fbyQnpcwQzCxxbpbF10alIC1YTuC+8JaK6m9nEv5EL+3WwQV9j9nNY9/ZXXegnCsyG7OZN7N74MicdsyQc2t/E4ZdqTgW4/YPRDf6qiL7BzUVzrTBY1ztH2imzCagydu9ieod+x+r2bpyE5CHy7jXtwJVpQfRe1hJ7mpGMtgSq85k5bTT2Kf/oF6hUICYR/qxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 20:38:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67%5]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 20:38:25 +0000
Date: Fri, 20 Oct 2023 13:38:22 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Ravi Kanth <mvrravikanth@gmail.com>, Gregory Price
	<gregory.price@memverge.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Sajjan Rao
	<sajjanr@gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
Message-ID: <6532e53ed63b0_21a97294d@iweiny-mobl.notmuch>
References: <CAEvOrRzE76U2g_8=V3F-4fqwosRz3n9kO+40E_iG74EcbQBxtw@mail.gmail.com>
 <20230823180323.000052d5@Huawei.com>
 <CAEvOrRyquLL6-d=vOyB9NNOPVE370qjV0zu8XBsTJmpOBx2UNw@mail.gmail.com>
 <ZPHyoJsZDnzpU7C4@memverge.com>
 <CAEvOrRw2e3cn=2fNXO8_iX0kg09an-OSx1fnjx7ciGGhZo9f9A@mail.gmail.com>
 <CAEvOrRy9qoydCqxq7xv1QNM+z+YQZyQORtqdDU2VcVKP42CJhA@mail.gmail.com>
 <SJ0PR17MB5512449C5FFD76AD50B3D3AF83E4A@SJ0PR17MB5512.namprd17.prod.outlook.com>
 <CAEvOrRwOWT5HuoUsjkUyt6HpXQhWVR2Hv6cxJPP+4+0xNQpM8g@mail.gmail.com>
 <CAEvOrRzrAu-2o9xZC+YBG_7R9hLSm_kZFuUZ98tA23NjFyAupw@mail.gmail.com>
 <CAEvOrRyMqBcv+6RseVS0x_6a3aJU82tjLJagmqCrgRebx5JaZg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEvOrRyMqBcv+6RseVS0x_6a3aJU82tjLJagmqCrgRebx5JaZg@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0102.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::43) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2114fa00-c38b-4656-b9d3-08dbd1ac8216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWTvuACML/m1Ln6PBQ6JAhNNMGk2+/Vtm0Y/KmxmCsoUi2iQwbQCH7AuzIXO0NrUusW85y3Fg9auUmhv1Tt/Ro0QgfRUNPwx3ZnTrxwXD8xpCKvJ6L6OPg733BLa9ucJzbZHNg5DaSGo+x6+ykfC3+ByFLqvYlmPY05NrVfq4JB7HGaLWJvT8KMoSh9vcZ28yKkQMRLIZnd9YqIkaSCKWLIzyp0hzXWoPmVhrBQHzEyJQeFNpZ4MBcaGcMVkwxEVA08vYvO7kJ9lXtV7jSR326Bz+0LhXrvCwIicJYAjiH91Xf/lVIuMn9h+kPywZ6lm2tEydaop99BH2c0gyGtjQ3cMunAd/1JOmGBFgRXavOiqpfRGjH8n4Jyy9Z6KQLSCzkzkve9SoFOt0CIaN/ML2N8WFYPid7PwSeEFKllTQL53ycDz17tsdDQSxqHRVHx1Zp3/ShDIvcsmb70scpI4LDFq3+XbGz0CT3ruOaAStkRST5WARgSbf9URNI7GA9X3d51LbcDFBQBdDQDEmkUjGL15oqtt5ujIcltYL2KIgMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(86362001)(38100700002)(82960400001)(9686003)(44832011)(5660300002)(4326008)(26005)(83380400001)(6512007)(53546011)(6506007)(41300700001)(66556008)(966005)(6486002)(6666004)(8676002)(478600001)(316002)(8936002)(110136005)(66476007)(54906003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU4wRVBCYUtYWXlrR1AwcXl1MmRJam5WSDN6Q0V4QngzcTA0QW5OSUJpNHRF?=
 =?utf-8?B?aWVET2tzK0NNdmt6SmVZZi9ydFgwbVZnNG1TMXgxN3JCYjdlK01DeGVlUFpF?=
 =?utf-8?B?WjJRQjZOTjRZeWFHNDcwNVdjQU5OcWlad0xQNFY3Qnd3RDdnOVlBQ3g5TTlQ?=
 =?utf-8?B?OFhpUklwcDQwYXlQaHZNQ3paWVBrOUpqL2ZkR2c5cHJlL0FOejZ5aHByME91?=
 =?utf-8?B?UVZMK3JsRVZXTWlhcHZvWFg3QWwyNFR0Qmg3ZCswMmRWRjZzZk56Ui9tTU1O?=
 =?utf-8?B?aVBxdVpaWnRONEF6bjJOUWhJaHVMcEwvOHh3cGdFNlltRXBkUWlKekE3UmY4?=
 =?utf-8?B?MUcyRXYvNm9XNVlzK3IxanphM3RYM3NsM2J5aWxwUVMzTkJvL0dnaWNGckJQ?=
 =?utf-8?B?RDhpSTJzSExGd0hjTy9DUll1Q0JpWGZxVExRamxtb1VyZXU0blRRK2FLbjd3?=
 =?utf-8?B?djc4UCtwZWxlR01wbldwbE1NLzdJQ3d5cWxNVUJ4bnNZMDY3ZkRNeVhCdlFZ?=
 =?utf-8?B?QWV2YUNRS0pYMVlGSlNXK2xtdFowLzF0NUl6Tm1sbTZWMDdEMFlTOERzYkZG?=
 =?utf-8?B?VUdjTnFxUDBLeFdvM1NVRkNpL2dtQWtrRlVPcDA0aXlRN2pnUGErb3BZWXBa?=
 =?utf-8?B?TERrZ2dUT0lHMzJUMjl2eWxiL0F2dHByTklqYmZSU2pnUm4rUkZwVUtoWU4z?=
 =?utf-8?B?cGs3dzYzN0FNUjFMR1YrS2NENHhKa0RUVkNTL0d6RGs3ZytjODFoanVWdlBN?=
 =?utf-8?B?ZmlxUnlYcm90T25QVGRPYlhZYy82VitYRnJJQjc2bFFVRFk1eXk0K0lCUU51?=
 =?utf-8?B?ZGp4Y3I2V0doMS9JZldpTzlTREk4bGtDSUNBU0V2R2orVmh2NzI2aERtYis0?=
 =?utf-8?B?STk3NzIyOEt2YXltM0xXZWRuWVUxMFZ6bEFTN0pKU0hXRnZNV2lQdlVWQ3Y3?=
 =?utf-8?B?MFFYcGh6UXE2a1JsLzlVOWFybEdLcERSQ3NOenFIYTNSZ1g4M3ppTmluSGhH?=
 =?utf-8?B?YkVnRDNKYy9kem5wZWlrYStxOUt6SlE4NEZDUUMycXAyWVY0c1U4aC8wRlF0?=
 =?utf-8?B?K0xNSVVSVHhrVGNTczBzci8xK0piZVplNmlUOFBBNitJSjVyU3orckFsWGd6?=
 =?utf-8?B?bEJKNCthR2xaMTh3YXBPRmZESEVGeGV0bFJ0V2dHNU5VUUY3MTJvQnF1dWZV?=
 =?utf-8?B?SzRuUC9vUVlPa2xoWHJZZUZqdVo5WDRNQ3ExcEZsd2ZYSUh2VUFSOWxxVGp1?=
 =?utf-8?B?Z0JNVER0M3ZWWGl6N2JXa0ZnTkk5a1VKNkNaN2h1Q0NUV2lzVjNWdHVZcnlY?=
 =?utf-8?B?anplejNTcEVvcFNQcEt4ckJFd0VoQnorcFlJL3MzMy9qWkw5VHl6MS9vc2JJ?=
 =?utf-8?B?ZkUzREJGMzRMRHpGNTQxKzJua0EwcVRUNzRYN1ZsVkxIMG9FQkYwS2tZUVFr?=
 =?utf-8?B?ZnVDWkR1aElONUhkVnRBSktKYW9ZV0hqUlM5ZldRdVlGVUNkYXNFcjAreDJP?=
 =?utf-8?B?MEJXMnhVdUZvNXI3a2VuM1RTb0dGT241NEtKYko0RG9tdEpuUTIranVmbGlH?=
 =?utf-8?B?VkRUb25MTFRrTWN2ODlJRldmaXB2bzdVSEVnZ3hxSUhUa1RVLzR5a2M5STVr?=
 =?utf-8?B?Z3NuV012eU16T2YySTNOVktGV2RvWEZTTlB5cmVLWnlrM3RvVzB4THBISzJW?=
 =?utf-8?B?SXF6cmVsRFBLMGJ4bElUOU1xWFJhWSttVnhsTjRzM1YwM0NmMWtUYkxWUGhP?=
 =?utf-8?B?TlhtZmpRWkJSeEc4a1g2ODJsbU94clhkeFVoOVo4MTk5WGI1Q3ljVythQzhr?=
 =?utf-8?B?eTR2WllWcjlmS3N4YklNUVJIeVhUNVhQc2tvZ3NiUE9NTmRCRW1xUFhnUWFP?=
 =?utf-8?B?MW5Pb0d6RXpHWUNTbFJTckdmQzZXZ25UVTJzaEJqNHc1dFo1L3BOWDZIZ0Vx?=
 =?utf-8?B?K1JWTzlZNDhNUmxnV092bG1qZTUrUTdycXV5UG9VeUFtRHJZelhyZ1FLeHo2?=
 =?utf-8?B?empWcmxidTF4M2Z4MXA1MjJaR2NobTJpQTBWYkxwbGxiZWVGcmpVbmFhTFV6?=
 =?utf-8?B?NzZ5V2RtaDRwaldqd05QSS9JTDJoMnVDaDRyMzd3VVFCdjdVM2pkNkQ5cC8v?=
 =?utf-8?Q?GIjy6+2vNlRNeOFnCSoWX27vv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2114fa00-c38b-4656-b9d3-08dbd1ac8216
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 20:38:25.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1cDVTbZmOBmCpPz2KYHY5UmBcbQOFrqBZl5GUSzn4zxz0n9j/bbze7wIfdtmbYZZzyby0NBWsKvSxhiSaEouA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8018
X-OriginatorOrg: intel.com

Ravi Kanth wrote:
> Hi Jonathan / Gregory,
> Just wanted to touch base on below questions and if you have any
> inputs on the same. Thanks for your help.
> 
> Thanks
> Ravi
> 
> On Wed, Oct 18, 2023 at 4:00 PM Ravi Kanth <mvrravikanth@gmail.com> wrote:
> >
> > Hi Jonathan / Gregory,
> >
> > 1. Do we have the support in CXL driver to read the "Device status
> > registers" and specifically "Event status register" section 8.2.8.3
> > and 8.2.8.3.1?

Yes the upstream driver reads this when processing the Event interrupt
from the device.  Then it uses the value to chose which logs to read.

See cxl_event_thread() in the kernel source.

> > 2. If an interrupt is posted by the device firmware, how will user
> > space applications be notified ? Do we have an interface for the same
> > in CXL driver?

All events are reported through the trace infrastructure.

> >
> > If the above features are already supported in CXL driver, Can you
> > please point us to the sample code snippets to achieve the same?

ndctl has the ability to monitor these events and example C code in there.

See .../cxl/event_trace.c in the ndctl project.[1]

[1] https://github.com/pmem/ndctl

> >
> > Also does the switch cci function change part of the mainline?

I'm not sure I parse this question but I'm also not super familiar with
switch cci.  So I'll let Jonathan answer this.

Ira

> >
> > Thanks for your help in advance.
> >
> > Thanks
> > Ravi
> >

[snip]
