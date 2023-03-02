Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEF7C678D4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 06:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCBGoS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 01:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCBGoQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 01:44:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A720D38
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 22:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677739455; x=1709275455;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oueOD11PCg/91V1I8tHKkro3mAtodyyY/mGuuHrNFaE=;
  b=WKzO1Fn/WOU5tumnjsFYCP8Di8JzrCiAepQzUVZ9Fp1kDECwHZufCooY
   QhxBHDHNagAafGhFvxi7Mj70cWyondD2rXwrMHyzHbbNWEUJd4HxJgyh4
   6KZlmSA6so2CyV31+1vaHIw4Bn33SIVux5FSKE/MTPVDc26ZrrIth/4UM
   useIbG1SPQMTTJGOu8/uR8lkhTo5ZkyuyPQi96ixKC8IkP31ViW4Yed8e
   Ak2yCUxQfd7ypht0lobecUFjwwBowHnWG13Y890dgHgyhvKugx/t4mMM1
   gzbE5+RiRAZ8lsu8KUCTuN+f1X11lGnIbc5+FO8JTuLj+HESyKRIY1+l7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336134466"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="336134466"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 22:44:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="763890262"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="763890262"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Mar 2023 22:44:14 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 22:44:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 22:44:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 22:44:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiYPMf0NX9h4r8zTKR/MSs/fLoRpGTTC3oftkxcw8Jlrpgfw4KptJmR6GXu7h67FLd3fdB9seVyCL/hzHiKRRP89rYjwbw/KeOxM1uVvC5hYvPRnsKUlDEcnY6n2VlEW/01BXLIwOu7d20vKbaDLj6KNcya6jfMCallizq/bu2+CImhGpSSwRBpnk1dAtVEJify5sdMaDOkilFSBS3bmCtA5wb42SpzfObhdDLr3k4p56YGFvu9DoyIWq38ZKNNkvpoL3G8WdByt/5JobKq2nrHQ7JDJV1DVHUtJ1Od0XWoCkzqX0K71i3l6Cko9GcOGTqvsVMQTBIIOXvYJgZphOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIEh/GE+J/i8dtNJ0VsJfaETrpDfuca5DSp+emoFcEA=;
 b=LUZOPUguBAsi9wZ61by0JD2J+Bcfd96Avx+XeBFlPstfZ0VazVFdwTs37/vUmsCcBwc3xmC9A+Y1ZHgMZT+4V37cCwBj4Mg7XGCdVb5g0x/xDm1jY7Ts8alwVxXJTyfSPJ7OHUloZA6YGdZiLRxtnHN2T/M/yo/TzOfArp+IvbV4SGr9ULRY6pcIKpTVAFiz9feWQYqY8zcAsZEI63etmOfP5zJ/xdqXYRzHErwft1xIqwpBnsERJFKh2XD8u1kKQAINS/e6dM2joG3XxwyX3/LDfPxoXiFG8NOHFZ+rrIT6ZuqF2FOlwVrnILivkVYeLDUGSUaoUICyMbl5/fpEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19; Thu, 2 Mar 2023 06:44:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 06:44:11 +0000
Date:   Wed, 1 Mar 2023 22:44:07 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 7/7] hw/cxl/events: Add injection of Memory Module
 Events
Message-ID: <640045b7d503a_3a6b529495@iweiny-mobl.notmuch>
References: <20230227173416.7740-1-Jonathan.Cameron@huawei.com>
 <20230227173416.7740-8-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230227173416.7740-8-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM8PR11MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 72476861-7868-4d64-81a7-08db1ae987c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yR8xNlbZbccUjM4NBhF+skiQscN/ANrXvB64tpFjQKYPAchgX/dx2bSefXYVJz7f2fdO86uhpm0q7R4Z7KT9RH1/+dSO6Mir4E3EHbWtSkCsbB5geDDKjh8eB3bvOt5F5kkMQ4VDqXD8ZS6EVstSE4XAdxKtwIOWgppvmOWnq0/CBUneXyWQ4xMngqP9xzstouOt2syme64GS9YA690oIqE4dOLOwA4x/7qGpIeBwrVUssCEJeqvWN4TffoGEnuE2+U1nTAZMjJ0dZCcUYCdoiGFKQvpZcZSTOI++wz/M/Dsj84nJdtjJ5aJvvdyhN1qmoh3/ypJuiZ1FbIoG92Tjt3XFwhYe1UfgryDzs4iw7OTx35UMnz7q1Z4N2/ebIzVoa7ep+xrKkP2lqu+Sxoj8fQ8tM8GKexWVmEqXkiuffYQKy/tEhqWRsu2TWwD7Njmm7j7nDMbtIDfbbyd7TAM0NDYsRTawWfUirUzpgosp3ZKe8TMd/OoC5Z6YO3RTCB72kDGpy0rOoWlcIuFgWlt2Aa4K+7oNh2uwY1mGso5FHiuWPOuuuZSzLZ4e038RmqRP2E54Wg5lDZqmLL7Vby+GCpdFE4WRI+jGit8ILg23UuBrIw8tpq6iP/pVaovsl4rwBg4+jVUKXMQKdO+tYy9rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199018)(107886003)(6666004)(38100700002)(8936002)(5660300002)(478600001)(82960400001)(66946007)(86362001)(26005)(186003)(9686003)(6512007)(6506007)(6486002)(66476007)(66556008)(2906002)(44832011)(8676002)(316002)(41300700001)(4326008)(110136005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lfLQ+40qTfzI6KLEMhInQ2P4a5e9Wq1nITDrJEmwOhvwM8uIp3NmJRtr7+Rq?=
 =?us-ascii?Q?Ks/oSe0n/8QzfnFc0ymjTmevvbuHfjIoQ7tjDLE92zy41/XQkbpfcNF3T+ph?=
 =?us-ascii?Q?z8NKibUSF2sq7gTGOnIlkuAH8oUD6fGUKF5WXbpyWAvkjjfqJ29/hOzpI1w+?=
 =?us-ascii?Q?bALFlSnF4DWbLbknJEKK2g20KxCMg17GjP21fRE40rtcaPVOTo2S3P/gH7+H?=
 =?us-ascii?Q?saS9vmhEEAt+21qBVheevtzQZ1yUwUE4zF0Q04/hGprxOCmHCknXRdJxONRx?=
 =?us-ascii?Q?bOPjEl3Ss8f0LaLoPC36ANNJKDe77cKXrbHoItBVChk1scbS3TdfDZFBXTle?=
 =?us-ascii?Q?3fPOB+BjU7mwIRq/eipec35vHm7e7Uj8LjN0/oE/vEF7XYqEosWonmxWzXrJ?=
 =?us-ascii?Q?WDlKW8lz/uBA7MYfbMar3T66xruU5ettG6BayqGemf/TN0/2zlCXUcXzJefX?=
 =?us-ascii?Q?l62uJjTvolR0YdHIV9hkFoQBEZeLCsSo6Vw4+S6q6iX+7f7zZPvqpt+u2SpG?=
 =?us-ascii?Q?plYI6jkiEnhlgL8JLutgtCUfscM3qRyl5TM9rD5FTXniWiNk4aeGUXbTx2Lx?=
 =?us-ascii?Q?sJYZ3ilKY4fWMppdLy5HJePfx+hsLD2s7Jy3WoCPPYTgQjCKQuJYpoKNU6dT?=
 =?us-ascii?Q?uhLeRJxp8TJ45vhM4AISQoUshWortb50ZBQ/YOFsvT1/RWqUYbu/1Pd7sQJK?=
 =?us-ascii?Q?zl0i+adnrumXqUefuOoUKBFzZaTYUagKeaTEPitf3RUOrqtDFagbQIV2v7ad?=
 =?us-ascii?Q?fKoJBTU0/zKGPOIcO5sMlLdv15vLLjl4/Vjl+FjO/6Aqpf4hpxD1ciAFa8gl?=
 =?us-ascii?Q?fUxtAixSRfJq7jtJfqTnTtxM2TSrzMMflGG150Tqi+S9CTzux7EHdvKfW5sW?=
 =?us-ascii?Q?os5/wO7TePlDHUrYqzhVDPEsi/MXsLV9AaWO1B3h8l3j3RL5IcERQ93IGQ2D?=
 =?us-ascii?Q?kAlodAJ0HcIzH0PvahY8wk47BAVozjc+92N0bq7NwbHEpAEmxPdmJ7VkO1lC?=
 =?us-ascii?Q?LSREkfPMV2MBqQaFv+qwnE4zpZkOrjXY500kml28R7M8QV/+FF3t9Vo0P4MV?=
 =?us-ascii?Q?n7rJzdhW46gfaFLF+ucrYiJj/FA8OOiC+AcNVltRg9GVWEPjRf+mJs0IFlgu?=
 =?us-ascii?Q?2cpwDtGQAC2/SV650QLgQg+n6pqykRL3TnaAMTIzw0xQ5VXl+j45qSV/0LFP?=
 =?us-ascii?Q?GT4ihhsHQ1t874X3cEGnbjSDSACa7OZwA/IBSbO1gWLz4t0yj4gYqla5fNy/?=
 =?us-ascii?Q?MzaPMmO2UHx0gqCIcHAdh+VBghSaEe8gC6vK6sfoNxhjPO6VyXpmwBs9Q1yz?=
 =?us-ascii?Q?ItTe6APgiIJGYyOYh7MTF44M93Ggj30yFSfbnd74aQZ+zXSPuMxbuUH7lQGA?=
 =?us-ascii?Q?cpvUB91ARHfCb2nfmzDL6HGgsLhjry7hyTXIHCXaDezkk0o+q5vAZk3iaENZ?=
 =?us-ascii?Q?SWcS+ZZpKJNO0tC7VK7yqKGyuXduxd7sr90x/A5J5/M6ALcRpw+F7PX7W5ui?=
 =?us-ascii?Q?gy+ARyLMmuK7z8mOVgv4+3ubPEp1IR7rV+zv+paW1N0zbrpDfhqGnf5KATGj?=
 =?us-ascii?Q?iPkDA/xv4kF6ZO8PHIUSBhMPO+9Z2jlA1madYk3/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72476861-7868-4d64-81a7-08db1ae987c8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:44:11.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftDHJdA38++7YdqWFEALSaWSXAEK+z/JZT8MNhKE2bFSzuMofjRVEMR7PN8NNiMhw5jzJ/Q7Atb4dPjiOkcx8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5653
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> These events include a copy of the device health information at the
> time of the event. Actually using the emulated device health would
> require a lot of controls to manipulate that state.  Given the aim
> of this injection code is to just test the flows when events occur,
> inject the contents of the device health state as well.
> 
> Future work may add more sophisticate device health emulation
> including direct generation of these records when events occur
> (such as a temperature threshold being crossed).  That does not
> reduce the usefulness of this more basic generation of the events.

Seems very reasonable to me.

One spelling issue below.  With that.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/mem/cxl_type3.c          | 61 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    | 12 ++++++++
>  include/hw/cxl/cxl_events.h | 19 ++++++++++++
>  qapi/cxl.json               | 35 +++++++++++++++++++++
>  4 files changed, 127 insertions(+)
> 

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 32f340d972..8b3d30cd71 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -90,6 +90,41 @@
>              '*column': 'uint16', '*correction-mask': [ 'uint64' ]
>             }}
>  
> +##
> +# @cxl-inject-memory-module-event:
> +#
> +# Inject an event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3)
> +# This event includes a copy of the Device Health info at the time of
> +# the event.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +# @log: Event Log to add the event to
> +# @flags: header flags
> +# @type: Device Event Type (see spec for permitted values)
> +# @health-status: Overall health summary bitmap (see spec for permitted bits)
> +# @media-status: Overall media health summary (see spec for permitted values)
> +# @additional-status: Complex field (see spec for meaning)
> +# @life-used: Percentage (0-100) of factory expected life span
> +# @temperature: Device temperature in degrees Celsius
> +# @dirty-shutdown-count: Counter incremented whenever device is unable
> +#                        to determine if data loss may have occured.

							      ^^^^^^^^^
							      occurred

Ira
