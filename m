Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2EAC6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 20:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjC2UqU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 16:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC2UqT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 16:46:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042954C30
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680122777; x=1711658777;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d1bHPxkeF34P6HsGfcJK56EPinDRX1S39AOOynwPSMo=;
  b=Q20xhwwE5q710L4Z6kbNm6FtwM+pPIInfWg2Z3MM4dww3OllIIpxtClr
   ViZzWpOorplH4n+Gh/yk1+UUVeHt3P4T5rbqyS6lnGeSkgB1+NheFT3o7
   rFBWbzYjPMrQ41+4umI5urXfyvQwOklo5dT+3OZ12suA3wmv1AWHwyKc8
   AdhpNbsiYj7aCNovEvRjxjf4P9KvcQNux5KD84UJDFw4KGz+KuhZyPxJt
   p8bRXQemyFuE6rzkVzmJkgz/mbiVxDBmzNVSmUuKH7hsHdEC8McyaZOZL
   X4iFStUvbZihXrm1hM2gL0X0nGh845geK0SivCv9mlNGgHHIPM89Zf9zS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339720488"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="339720488"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 13:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="677925589"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="677925589"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 13:44:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 13:44:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 13:44:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 13:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX6n5i4xah/LFUdxghxBYunZ1XdfLChG9oT3iuWHyPsVkFGs9+3sgHMvvmk9m/5AT3b0SMGDOQPGUw0aKrxtQez/KsxSl+vprnA0dHA8ymrscw3c1Cw3W6psE+18VsyxVVnomvuOlV9Yu/08VgzLNnAEf1LHTRhV1V7BEMxxK5wQvs7IuRRqpLOgEtCvGte808RgU8qEnHVVmafKpCJwqVv+tFyDuWycTZsFWbWdUUwbAaigzwmG1xE7vsF613n93wzMMpSGT5COliy0NitQXHa0Gz9MCX6EA+WpkfIEtwh8GQPzQ5mWCFAZV4DZX25gHXDz2EuJsJpLY7vRCXAHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXi7P1aBkk8tQDnz9Jcsr3a8nZfmboWriaorbaUFICc=;
 b=ksJk8yozMpQipP6BCNLyBfVbAb2zIF299URYAOQ7uTCIG0AKS+wcTxtudmtI16xXS/fjPJhYlcRB1n5CJY8IAK3W5DpT33BWzyEVNVxspaRoseb45GyuRQg9HGrc972YIn08OQl6NC7RuCQs0f3jVbOFG1aNZiDgETie+wrvEKfPWpShA5La9DVww0X+j/uCtghPX/G1ziL3Mc7o57HFZFWsDaj1M24FargZp7zuKAYqPiB9DDTrTMo2jqdaFS5dGUpvescQ2sWC48JkElCh2x8/aw6wrFQwzaHKefXVZ9v0J7Hb/8ai70b5liinrtvRTsgEJaHUmTdE6NsFf8P1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB5989.namprd11.prod.outlook.com (2603:10b6:8:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 20:44:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 20:44:48 +0000
Date:   Wed, 29 Mar 2023 13:44:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v11 2/6] cxl/trace: Add TRACE support for CXL media-error
 records
Message-ID: <6424a33c7463d_353be82947c@iweiny-mobl.notmuch>
References: <cover.1679888450.git.alison.schofield@intel.com>
 <0232ba1799a982795b8ad8115d10b664de0cf937.1679888450.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0232ba1799a982795b8ad8115d10b664de0cf937.1679888450.git.alison.schofield@intel.com>
X-ClientProxiedBy: BY3PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:a03:255::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: f32bd623-e6b7-456c-0bc0-08db30966f79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLJXfK1Tckq7XTurSawOHFhqIwRK80LXXdfnQLrKLWivY5tAzEZBH6EAw/mtcFzhX6NWaCH7FXxbdJer/+ys3GJqul32iApGAcu23cbSpC2KjteUPDGefr4LA3XcJm50PCu9LQtng9R55GMZgsYiLYqvn2FSe0YiNXuIrJW1QRaTktL6T5f7QQevy3SBarzoIaCT0IJnJryFnW/cq52n2VeqyKdIkVgH3JUGmZ5v5vL7NW9vdVW6q4Jsg83QHIAuzll+/k8UDw5dUxHXud1mcfWb5rKcQWxuFnadNqlfW5Q/O6Fe3EM7M444QkZ7yNEMbUpLfOioNvOUiM7cY5hsFUFtK59jO+BMpP8ScqqAk9be1jRpf8xdE+A6bhw5mfuJU/fFUQ3C9GeZUuLwGbNrXBASucmcKddxqwi0sFSujWhMWVhfScyymzCKldafNXT/4mnjelZaw8ZhudMkDaspWGG+PQ5VSm2phiqCq1MKQRpfGv08azEbss5iW/Aaqn11bbFajPwNo1vmNTDGP+/91S1tybH/e3KIYuSdrfKkGfKj/AjCSpiIX0I8PF9wxob0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(5660300002)(478600001)(66946007)(316002)(66556008)(66476007)(4326008)(44832011)(186003)(26005)(82960400001)(4744005)(41300700001)(54906003)(8936002)(8676002)(6486002)(6666004)(110136005)(9686003)(6506007)(6512007)(38100700002)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p2lLcaINjrCJnQJG3B0sZ+4EOdNk0yTF04mzMw1zwqaoMDX2gtBwWYUFe9/z?=
 =?us-ascii?Q?frbynFWRK4vFTeEFabRqO4wUdnEkvWoLSauE5bEohTOSqdIZbqmiWUSf6BQF?=
 =?us-ascii?Q?ap2zbCR+OMxgFEqPRyJNjdcra0uWDTyTvvJBcMXCiAjZxRBKiIkic64uugYP?=
 =?us-ascii?Q?s5GE6Y69kK3xA0+IZG2i8xYtQhEuVLXyNuRXjWT78tcHyLO5d0xUIiWVLNZh?=
 =?us-ascii?Q?g3lC+TSQDFL6mGxGttDVsoqOSnlQQK8wkAMtFn+4roEDbHCuFYpLggNUjdTg?=
 =?us-ascii?Q?lDAWUeV1hJEQXsNo3TQtHzSeA4jSHkuxO1v0q6qQM67Hf2eUtk43GVKYcma8?=
 =?us-ascii?Q?mgcekp4V9vwWwozECBdsWZDMxiC484jBTogHR/gADOr0BFZGSgLSLUKltLgt?=
 =?us-ascii?Q?tJ8Iupzk4MdjG+Z56RlqjnpvhOkHvFieeygRc0nJ32eLxBpTr9gPRx7vGIsd?=
 =?us-ascii?Q?Z4iakLic6r5AXOc8EKMHqMdc2cbzKUO3c1TfIMJprjvaNnEv1mRAHVKR5QXP?=
 =?us-ascii?Q?qBxFRFYUynk6O8MC9eYD4SzfVForNjj/FY0NZa1U0zriHSwg2VT5hPf89+vz?=
 =?us-ascii?Q?WPFE8I6F0wP/PVU2jU9KbVP+/nzgYzLpav4AnQ5/5rchbiIgz0jgrR088fZV?=
 =?us-ascii?Q?UHe6Uq6YNwOGJaWpk/7koNcfyMIkHCCf0GPopiWx3zZrr3kiin6QZU83luOB?=
 =?us-ascii?Q?Pe37ZyRcnSP4X3XDQ062gcLxFQ97D00l6mwxv9NuMhS+CO3ecor9AmFDg2nS?=
 =?us-ascii?Q?Jt5TY84RJMdf9hxEXY/PAfVi6ZEo06WdsjBdJHYGT8vJz3NroQadAyrBMTOf?=
 =?us-ascii?Q?NiP+sTzBviS6Gbc3YWIuQ9M1XSSkR6UglRiRoxxUHHu66UT9+HTSPrLRzJrr?=
 =?us-ascii?Q?jF2cOTB2MNOtgJi+CE0Bgd9c+GkplfVEdCOBLJnwozDMm+34kBn2iDx3UN1v?=
 =?us-ascii?Q?65JFMvTlY+mczHccbBeRb53cn3Lixccz4TQGUdZynMalsvdmzZVANHZHAN41?=
 =?us-ascii?Q?fzpY/aGCZlj5FMTKR5SRLylSQ7Vczw3t9t1e4yx3zcycW2uWbLb/23nGQ57v?=
 =?us-ascii?Q?zz5o9IJEk+CJ4E4DPLedLZPCrM00SpKE7KZnzTwcYxv0uaiN2YViVygvfpfi?=
 =?us-ascii?Q?dZaD/qXJBQKaNKY5gQR1XHfniXI2PNIgFRynW6kApyBkiU3ekaFS3f+pBebB?=
 =?us-ascii?Q?Li57HWSaXxkkHIM3D7FwHQcTvMSnHB1nvl6kBKqAJdNMPjlYj2CjNkJyE8+H?=
 =?us-ascii?Q?0nv0eqBZXsKr5FOUehspy1G78TxXJaCIQdlmKiMG1Y5PHo0zZaIBpjsEHlnK?=
 =?us-ascii?Q?d5Aluu4L+eOfWNiXsNmVjDaa3WM4puflqgmum5AGd50jH6Re+5a39ia+C/bz?=
 =?us-ascii?Q?uPJT/4SHbSa6Fr10PM0WT3+iaDjuENRqi3/3ChSdzI4/QUU5FnLGzIZd55sy?=
 =?us-ascii?Q?tsAp7SxKeYl9B64G90bhj7TkE2+wEabWwA2p4HMRS34zJustmNOFMQKmW8HZ?=
 =?us-ascii?Q?iEPHHyO2HlWqYSxV5k7CHFOhcLQAvaSiqFyfEP2Yf4OW1aNlv3DN2cK70cz7?=
 =?us-ascii?Q?1ov87OYYb6ZAzNnVwBqvEgLQvrMdha3g29UGFosv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f32bd623-e6b7-456c-0bc0-08db30966f79
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:44:47.8818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGgMSz00oEu5FKR5AKQMse8TTJcAcZE3uUPxdvVJFLUTS57szAZAvTUDz9qxy1GGvBOZUeDRIT2kgVMqvRoejg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5989
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices may support the retrieval of a device poison list.
> Add a new trace event that the CXL subsystem may use to log
> the media-error records returned in the poison list.
> 
> Log each media-error record as a cxl_poison trace event of
> type 'List'.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
