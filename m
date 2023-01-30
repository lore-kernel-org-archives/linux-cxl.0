Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E132C54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 19:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbjA3TXt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbjA3TXs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 14:23:48 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6175E3C0D
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 11:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675106627; x=1706642627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KbXMpsrHQ4CVz0iMC41YFQWhWjpBv9ZHSuV35uyraoY=;
  b=H5xs4wQ4u23dXsjZwACuHBkIGVHKwBU//D+HS20QJszflMYttNX3QNuR
   7H87/LGGUIh8g5QqvLZkGtRjgbGzaHdAxR5g2p9Y6F2CpJcNNObQkSzz3
   /YfbzFnOxwNyVDDt9/C0s89kuH+FNbGFRNjOX9hTI21OPCBrd6XYEcXLi
   aqz0DOeFrTY5E7ershv4TX+wh+93JQ409bwL2TP5NSdihYu+PF7kFGlLH
   pnZrJE5qrUuiu8gZAYfZOi373l+S1V6a15x/PTdhVL9nRvZ9QKHgxBoKo
   CQ6ZSsDWGriKtMudJCOIfmIVcyeYOHA6CnSJX4XXHjAUnSOgliqYroZ3v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="326313726"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="326313726"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 11:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657579201"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="657579201"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 11:23:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 11:23:46 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 11:23:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 11:23:45 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 11:23:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrqrlOj4L29kT/MnLzjS7FwvvwSLgfBu+eqDZ+YM8tY98QsYBldj1xwSM2Zzj8oyOK7NIY8fK05YAF6tNsd/kqfYDHUYT0TzWvzbZpBSpSU2+WhNKaG3/MQZZKk29Tuzk1uzIscdwpbmronEiiMmbQthDBVuz8hkhmxRZFK9bLjSpmrH69uiKEWfgPb+lMRhjYwobWTwv2sizDmhYLqG+6kca/qyVA6jFEUgNhsw41jHl9XMrEF0nUUzM2DsJviYq3IUCSv0TAvk74N864TPa+FwAjnzn60N0t4Fa87Yq9vn3fe3GEvpp6ESqqCd+xEvYtGzJ+WTanImTWQO2guQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1blG38UQt1zq7MqRcrrO+pz/zRBG6WjgjXf4JTkzXKk=;
 b=SFXR2zBQDI2Fj8aPjcpv5DM5ldH36kFq6UEW2HsSkLxKNqF5ZdPwKdDpD9yUMK8mmO6mFhYZgyKsOCdgjmm/FFY+zNjD4mfoku4CW5KwN18PzHqD9pv6pScy59JOIItNUzTnWcpaMBVourklSN9En5eq7UyhIleG5t7iXljxfgM6/7MmlVjhf+8KAZJk3iFF9Gu9CTchMy7PGQh1pm0HaCuHLHUQiqRLVi0hbA9RTi/GB+kK3ANrAmU9fCkO5sxBTM5f/6Z3hD2e1o99FdCPkd1d2//gU/29/n3gYlgVd/PRprzV1mjrhiDKjkRyvK2bMSAjUqwAKFJYkz8V3QJIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7016.namprd11.prod.outlook.com (2603:10b6:806:2b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 19:23:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Mon, 30 Jan 2023
 19:23:44 +0000
Date:   Mon, 30 Jan 2023 11:23:41 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: RE: [PATCH] cxl/mbox: Add missing parameter to docs.
Message-ID: <63d8193de1e8e_3a36e529448@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230130153437.3153-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230130153437.3153-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 31094357-0009-40e6-4859-08db02f7809d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqcC97plcMlqCVlt1BNKxGgimTQgDO1vYc4htGfneF7SjaQla0juwURx3XxN3NmjHuvzNtCF84wb06Wk2HSUDrWItahzZ2IYOP0a0i1hnfsoDXlMjw/wtNEQqqBFUzK4pB7mRPI8v+B04svgOKkApQ2iJ7OjTlsR+hSs4Hz+ZlBpB0YqVphFgp4QIb01ZtdMYrbO2OOIHRcLUfzVmVqI8CU9bOVZLYHlHLlnAZN1eCIU3Af0pvBSVaxisYUGjf0NFqA75IBESKGZRWgmUtjnL7v+8bHDmzaHmjVNfM8WRBJG+URFYV7YfyXCTF6draJDAN33vEmNJVSd6cztvCnSjMakVMxhGQssRjVKF2XUqjKje8m1mkKU3zFJTiizM80qzFJh6/bsK8M9eK0QpisCH5fxuiHjrWBABpMIK65VRuaCxCBVWUUOX9LLJ5Hw3SJNNFfhauHPjLIUa0RFgoMN4yvSrJcWoEDDkHyen5HHUeY40iU50rmQRJZZoJOX+XbGtrNmCEqJ4szkwfjoQrNvmQmwVLlbfSYgTNw2i2uyWeM62f1m3iwGcHAbXQRSzxRcPwIpY7oEF4cfMhrN9Cek1/4Qzu6n+z7MhC5Icc2YcLWv2NgPxzkKcn9eHTta/vfXMCR0kCpOLX50nE71fP5Kyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199018)(316002)(54906003)(41300700001)(66556008)(4326008)(8676002)(66476007)(8936002)(66946007)(86362001)(82960400001)(38100700002)(6506007)(9686003)(26005)(186003)(6512007)(6666004)(4744005)(478600001)(5660300002)(2906002)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fpvc6OEqtlC8MDVx9VaSLhuLuLONUmIyDbjAqYRs/iYJ3iN2tXW13uRiOqnk?=
 =?us-ascii?Q?k10k0tM9S52V0SfsradHX2ZHXrr0aGtYGaS0w7KJX92mm7bw0TrbNf43JHXT?=
 =?us-ascii?Q?w1dvEbbRVTAs5HUULpZjyxpnBu1+o6pBqzWU2p036q4rvz58cVFhuK+vWK+I?=
 =?us-ascii?Q?Xxk0jBm+ZEsa2RiluMJbF4B4zrZsJwW/QPMNELTjEE+VTB7wQUAUUzxSdZvO?=
 =?us-ascii?Q?Lnbuv/FOPbiEjwlIhf+GqYD7fIJ3OjqxtzHNC3EJ7G4HvesKg0G9Sh7vpPcf?=
 =?us-ascii?Q?V+kAvIEB2Z/h/I8QroSRFK50fubrdiJKQnJMVa3l+mSVv0pQFaISDvPY/jha?=
 =?us-ascii?Q?ZK9JhbHuF8+mjXDDEaQALzApCAeQv9Wg0Awr9dtvEa830Zkq8cou9M9A4ceG?=
 =?us-ascii?Q?gVnQlwtUMCynfv7DP+C3CLM/7t94/FwQIzFcivWV9O0O1JxKRLJxW9rmYImg?=
 =?us-ascii?Q?4tCd4Tx0Fffw/5LOdmXhzSKi9bbVtK0KW0CzBMtPrwBLqUJbCxsn5ZggVXpR?=
 =?us-ascii?Q?kDpJzz/D8cixwu11/ChNUehbPhx9HAxbYItqbkepQXpSXGEISdCX7hpgZiDZ?=
 =?us-ascii?Q?OtV8HjCzdX25BTav8rdEbMjhCnCq2c/U3dpcwGFZIwaBT/MI++8mT0yYbQWR?=
 =?us-ascii?Q?PG8G/cfEXXBBwSc3Hlf4xiLuLIvDyrY/PX0NP/VolxknhW7353T0ntDdErW1?=
 =?us-ascii?Q?C5Ewi+R5gXxKEcFAm/oarrOeFcpm7ysyzif8QplgIWqpG95hVaAQX5iEtbuO?=
 =?us-ascii?Q?U4XAvBNUexLiQh0txEM8hX51Kj/cZqUbmru6Af5ggdgh9Zc2qwd+1s5s9bJe?=
 =?us-ascii?Q?woKSmCbWgd2jwOloP8eO5RDfph92ed2y+/dR4SKbnHiNt4saq/6ULYspKwG5?=
 =?us-ascii?Q?VNuhA3lIYOu+YXEd+/2j/phvZ4Tr0yO4SJi6UtKU2R1UwUX1nX9Zz3GMSGt/?=
 =?us-ascii?Q?Om+rHLxMLI6Oel+rJDpkYnJOtpWCae2QaKo/WFiT+C+RJo3xVcHgAxlqBTNC?=
 =?us-ascii?Q?ppz33JkPxOyOrtriT2bZ/PdEEj/+7AgxxLimZa4ym+vvJIqP92HbY0AjVHNU?=
 =?us-ascii?Q?MNI0ZdK7LenYMXEBmyrK1GtzT4gJ6lwG6aM7jHpKHbvUFTYYZ1w8TmqWs1Xb?=
 =?us-ascii?Q?1pAEdykHWOltv6G2L56CnOVVx7QE6wL76S1GW0f+4lRvFs0hgl2HFaKlC3Jc?=
 =?us-ascii?Q?ckI052nnKGHv6tLXrZBix4gnlsvbVtmlfgiTYUyk3Wb1PjXMo6HwwQDapObP?=
 =?us-ascii?Q?nu9ku2TQvZ/ayLqaCt/u1Fpdkn2TBws9NU2szwdlmFL4A1r9Cjxk4NUZt+EN?=
 =?us-ascii?Q?csplZuW9hVijpWlRAxtZzDszDiBAIw4+1Z5KFyuq7oX3bqufPP6SABHYHH+E?=
 =?us-ascii?Q?gLgER96mN2b/xQpvH8Xoux7WWmW19QQCMRWgACamuJhkgMqpEIS3wDF18gxm?=
 =?us-ascii?Q?1NeFTxcmSWTWpqS4mcdP25os54mTq8XAuwWrWGZoJwC+ii4zpG9NPJSi8TPZ?=
 =?us-ascii?Q?o0VCOc6wIf0+N8IYmPfxyZLfXHkseJD3hLIM0pMoS9Nt+fgd6y08sa7KAtGd?=
 =?us-ascii?Q?X/FG+yaxHIJFzMU5ImjIyhSi2H8kxrrG64nJqNjsIAciUfbJ0B72s2IFDzHN?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31094357-0009-40e6-4859-08db02f7809d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:23:44.2588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vu9kFxcWtRKDrRvn6WIy7o7aU4l7bcj+KV0wh3JTiYeJKo7iYH/UGQzCZE6/izCCZAk1hXYWBI4t2uTEPpr34ZqloFI+zWny8K0Lc7GRaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7016
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Kernel-doc should be complete, so add documentation for the status
> parameter.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> Fixes  ("cxl/mem: Read, trace, and clear events on driver load")
> 
> Bad fixes tag is deliberate as patch is currently only in the cxl/pending
> branch. Feel free to squash this or drop the fixes entirely.
> 
> I'm odd and for various reasons run W=1 builds. The resulting
> warning has been irritating me, hence the fixlet.

I appreciate it, looks good.
