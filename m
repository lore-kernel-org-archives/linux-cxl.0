Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14642C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Oct 2022 22:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJUWga (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJUWg2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Oct 2022 18:36:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E46F2AD336
        for <linux-cxl@vger.kernel.org>; Fri, 21 Oct 2022 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666391787; x=1697927787;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=9l1OjF43gU+ehrM3fxURj/+a+AyylMHBcnDu5rCMSow=;
  b=BwJ2Ga3XXpkcLuyHHsaE97h+nIRb9C6RHwnae4IQ5Jrl0r46JgA7VL5Q
   DV+ZYhmvW4drdZHcnUrxQXz2KLiDbMzVGUxMgKxg7OY2UV/AvtG2TjiUQ
   drdsv0yEt7Qgn0oBQbylyf/1NRETloiekfDO9d33OdSq8zv1lewr8PPb4
   t6UrtPzoXmT7LFes3rB2Rp2hZ2qt/neO3XPMFqhHqqp1jMn1OIKtH154l
   nAVQ//2EEpbnZClFCrM5xRkVT6w34sT6qSu0EpDm3ZmHI/Xku/rLvRfYG
   Avym1FXSTCYVpJN0qr8lpFGNmfKQr/UhuhQZuFaEQSlsLkafi6mNDdvwd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="393429489"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="393429489"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="581767877"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="581767877"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 21 Oct 2022 15:36:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:36:26 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:36:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 15:36:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 15:36:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQN91DRUtC4mXidiFlfen8xElLKS6Hrmy/HNzjgtBXwBmWhtHGbEP8ebxqMf9SMtSuTiErcSfI866Oetf8j19Ac+Vr3pD/lnpqBBrr2qc9ws1qwo1Led8akgdPyux002hUqEhuJwRmCbMxgyY6RgoCc6gMRrsoVlhJOjqxxYjf/tW2FzUKSRKI7T7j94WItGF7NnDgcUnR3qGi5fwFcSq8JTj63JHQ4WhSbceQlE0Qc0wvu4fMIpFb8C1q6xcsEAkQd7Y5yzXMRiTXKHM5wXLpfO70OjP0w8hdhB87q8lNFs6L+kJs8/2QUHwJxLBIN2pwvk9cOsQx6hsu/WQMPIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW06nrNo+8Spmr1s+LTGWMyaHD+AF831EeIi3E52doM=;
 b=CJZaKTOzGr/JHrN0V+fYt1kBUI4og27dPvkzXL2mJGCypUPLer12fj+A+ucUECZLQ+AgGc6barqKiLDlee1hLCp2RU3VCYyNsM1YRDeG/YBhPB4DTxnXwZ4GFXCkJ7FTJ0Ozo08enbxzR9p5F3ggZOMsfQszgvctzqCx6Od94h1MZdIO8tc5jDVj5soOUmZHbWAo8Gu/PhhmLmmTr1dG04RFDgzckbo5SyMgquV2d01tZljMSOfq3RqZhx10DQFp97IxiIiUkQDcB45azyEAP5TA7xumonqiJQpzyGZGq1qaQUYnSyaEnPPicvhFADd1zLdZ5xcat2+1bJdHDg4/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA1PR11MB6784.namprd11.prod.outlook.com
 (2603:10b6:806:24c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 22:36:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Fri, 21 Oct
 2022 22:36:23 +0000
Date:   Fri, 21 Oct 2022 15:36:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>
Subject: RE: [RESEND] CXL_MEM_QUERY_COMMANDS returning commands not supported
 by the hardware.
Message-ID: <63531ee51c104_4da32949a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221010135925.00006e75@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221010135925.00006e75@huawei.com>
X-ClientProxiedBy: BY5PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::39) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA1PR11MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a25bcb-bc65-47c5-d8dd-08dab3b4ae9b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfJXdiazTPKvwi/JtwBfNj/iX1lj6Sx9spcXIsxYD9uR0m6C7/+x6C2O3dO17+8myu+HFpR/HdWhLAwCS0HJE7L+0hLsv1R83q3fbnj1WG5R8cy6dqJsn6nlq6qbZUJ8I4Suqs8kNjhW9Bj7NRSoQXCiSapyy/vivNGHHu3rrgagO45poBos5ZScxIDHgc1QgdUgX/QiydNM21YBaEc9bvtKG0CXLuzn00yuP8pnrLjOg3trPJE+jmyuIonnx+eVogWd0CSyK053r8QJ9yFpuFHkbTzEvoRKWIobujIiU2/g6fag+Ro9zWuhXwoWZ8etuYsEZkhLBV/KhtV5pHaRp3vtjb0TfXs1T2qO6C1+Oap3q3EOm5QeACIIi8XlhJ2RUdBjQUhgG+49XsbZmdbcWMILlW9fIyQ8BSEBVwv7LQI4mnChsI5efJMRy9oWNm1u+SxiQ+U+huL2LnjGI8q76I2Ejs9eGAVK/pzAw5Lh0bJ89U5suUgA5n/P7czjS7yjkvrgUx5BX5LCKGCwOOkCuEzZZzEt/6ueWn3tr0BF2YskH4ObPJAZzVJahPgRh7r0+C726y2Vb+4SkeEDXjvyO2ERjv0Fhq4SJsS4jUWhShXnmjAqETHhoUxmYelEJM1vDV7T7v5EGR4gY3c/WAE7BRur6O32/mQHe5nRTJje8Hbzgw4z3eK8momCDRGY+I1Sluf2maFvrHgxpsNyOGOMbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199015)(6486002)(86362001)(478600001)(66476007)(66556008)(8676002)(66946007)(38100700002)(6636002)(9686003)(186003)(41300700001)(4744005)(26005)(6512007)(5660300002)(8936002)(2906002)(316002)(82960400001)(110136005)(6506007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9XylMChpSNbHTM89eCiOpNa2kJQqASyZ/2jQIVdhuovmSFMjieO6/ocu0jJz?=
 =?us-ascii?Q?vFPT4mA5zLsBuWSrA5DjZ5F/Y/0xuB3eWe/g6mMAi7aBGhyQDy9PTAUlxG5Q?=
 =?us-ascii?Q?tJGZrzBPvRzv/MdPAAaKYhTjOpMMK/ufcXvHNRjlNze0Uc65n8FABgAKZDEO?=
 =?us-ascii?Q?1KoqbWSgOHVp6q5+cXUiwDHzxthMGVzUrDQMod1z12a0SJHV8qQ4uHS+6Y5p?=
 =?us-ascii?Q?NwFUADaebSZmK02skn9STEPJdJwEHP2ooxq9fpT0lblOgJ0WE5dh4QdR3nrW?=
 =?us-ascii?Q?Y56xYnUdz+L0S8PqGVxN0w+evTG7gh0uCJadDrwFE05a+/GyFYDQ1HMrf+q9?=
 =?us-ascii?Q?gUlVIA/piioUXiKi4PUqSgPvLLlZpTKyQfCD+jox4iMYzKgUTiPbt9MVu5Eh?=
 =?us-ascii?Q?DoeaQXGK7uUwiRF3Ud/Y24yFhHYCwkneObgQePe89TsdxB8x/1zWiSQSa0G/?=
 =?us-ascii?Q?0fkIRO7JjwQSyPE3Oi0JMmkC0RUp9ynD0Ra0xa92vHe+QgYcRs0nYsMYPWAO?=
 =?us-ascii?Q?ko0e9GvzemG9a0DqKZBo//j6xMTbZbFYZs2J9SBWCo5DWIaeO6EqzJlHyDSe?=
 =?us-ascii?Q?8Eb2LX+TutK9FB6Swo+WEFvHUN2qDGfeM0YHadfnhzZxrHQSUj6kP5n3LxPk?=
 =?us-ascii?Q?xVa55z+3WiJXnEQ4EaXc1E/9OZ/enAsN9U171oADAIsFWN1QtDilmmZfPFtv?=
 =?us-ascii?Q?qeJTzcGLmVWJo0P9LVw3xQdaY7bfgxAre2GkrsCSjwUWiFPaM5CHF5TuNFtn?=
 =?us-ascii?Q?jWxx+aYoVtIxLp4cDyM7dcf/Qahjd2xJefiHmiPq+4woxKm5E3yaUYBuY4cf?=
 =?us-ascii?Q?RolnZ68/Ni7esLcXNx/2bMVXa5kyIsPeSJJXYqNvzBx+3+gmnBK/3wHo63La?=
 =?us-ascii?Q?H4xw4Ar+7cRIDyV5xT0O21PSismhc8THcwgR47MvHcD0XfAfT66a1THMWXaz?=
 =?us-ascii?Q?f81HBAcE6YlRYnH7PFqBtxsH7iz5VgLIpf77hRq7ICWP6dUe7c4R3RDQxI2V?=
 =?us-ascii?Q?UXicqfpryH06EE7g4jGyr53mdBjl7oUOEGGC9zEVOvcRDSv/LdgGIaQwu1cT?=
 =?us-ascii?Q?PdTRFYYgEsGnzlIjHUGAou2wJ17akxxlT86099Pv9P8nLgC8Od/VqPl8wRpx?=
 =?us-ascii?Q?pf/lIhToCnS5D+ZTArUdlhFa5i/b3JV7F6KoMEezxxeB/Ni5WkGUMgt0Mz2T?=
 =?us-ascii?Q?bVvquTEPmAIUeZZEVIX4KCFTGkVyYDfUIsVXvf2uXOEU8F4R1KnWNU0BnAoa?=
 =?us-ascii?Q?ni7qP5neoUUT4Oc2T/HO3N9jtMk2hCi3SNAzV60x3DYn7G5sYpXjjRGuAbNZ?=
 =?us-ascii?Q?UO4fg56hq3Z0SPiMayvRSCwm6Tiu1jMrtugJg9NWC0+ML10CILhEmvenvVvM?=
 =?us-ascii?Q?PBWUVa/jioQ1Y04y70jWDBiRA2q2isLWFweqMtBImvjmaYStoBSqpcJzD0bj?=
 =?us-ascii?Q?IcoVoUgmqnilroBPflofE2QbDpRpdQAUJLwfngm5b3GN2mmVu4yYATnmvJVW?=
 =?us-ascii?Q?PNxgozbSQn2O8sVYX3oMZ2/AWaVV+rxCoI5PL0BQJuL/KZBz2e+HnpFnpZhj?=
 =?us-ascii?Q?DGBCt48KZjIsoqFbbl0bjjGLJwhFn3xzVwmjws4s8mJVPuN/F5zOD+dM5iqm?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a25bcb-bc65-47c5-d8dd-08dab3b4ae9b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 22:36:23.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLSTwLqBNEIlB3l36TlkcHkxASk1jcHfrgwN/WFMtanvXJ3hvpevlzI9EKpLIqrbtEIG8m2zAQa98mQOPyRf3/fshXuqYkGg6V1GFYjaQWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6784
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> 
> Resent because I can't type email addresses so this didn't got to the list..
> 
> Hi All,
> 
> Noticed, whilst implementing a switch CCI mailbox version of the same...
> 
> UAPI documentation include/uapi/linux/cxl_mem.h says:
> 
> struct cxl_mem_query_commands...
> 
> Allow userspace to query the available commands supported by both the
> driver, and the hardware.
> 
> Currently it seem to report all commands without checking they are in the CEL.
> 
> Easy to tell given I just added a bunch of switch commands which are
> apparently supported by the type 3 devices (which would be novel).
> 
> How to fix?  Make the code do what the docs suggest, or change the
> docs?
> 
> Or am I missing something?

No, you are not missing anything. This topic has come up before. Why
have a query if it does not reflect the state of the CEL. I would be in
favor of the enabled state in the CEL being communicated in the
CXL_MEM_QUERY_COMMANDS output payload.
