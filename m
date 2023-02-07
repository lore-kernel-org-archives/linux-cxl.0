Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01585C636D3
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Feb 2023 18:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjBGS0S (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjBGS0C (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 13:26:02 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D7B40D1
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 10:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675794338; x=1707330338;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EOWIxZzXAG0v4OJ7Pfx0uroznWVLoLLji/ks4jZIAk0=;
  b=mvajC53S+lOrVL4DyVI5QmSvJdVyyts6/V4zn5/x3PXl7xy7zQmqx1+h
   jDHQ0ZDnFDTk0jV8kUZGoW0IKXsDs54wW4mkiBBz+Xi7SuFRMXmpmq1qI
   cnsiprNeyKYZFdgyYkwRXErl8I38ydYgXfJsdj/faN3x/mmNOkO6QKlMn
   Fr0uxMkEUNA6wu+jIfD1Q3ZjA7opkZQfFh3JwPi6Md9jfh/HSeS5BKaRY
   qUfkSxFSGv7bFZCMyAMv+KvMKGANd5N4iR83oDsMZykvNG/JkgA8QYY2A
   P7kqjinXjVd32dqImuoclfCb6e4QfK3Y8Q8q/cE12taV8fiNWPY8D7keJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="309927966"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="309927966"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 10:23:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="699345793"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="699345793"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2023 10:23:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 10:23:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 10:23:58 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 10:23:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4egHUupJ+WBGRKaM5MrWtYBHEx2vexZaukidIOEg66aSudgd2W4HpadUiwEdhvc+zyOcbDl/XgObAhwRp5R8UBtzUTBdRQM2+Ucl0rWayPnYXeX4kx++uA2VHwcod5UJ0avEdh7iHK+tJHJz7VKRyQVfFyaqWn9z/r3enOkaU/rXtdbnb0cU59atDGh+LnUTRP2qzH6xFWdEuBYC6yGmo/Sa+ezsVw1HusQzoxoWNwRWYbqvNPkNzIeDzVROhhx450jc9sbDe/2V62wv/JbfmKAH9Pd4gUTXb1D0Kc3dfaR0fQMBIM5gCtUVWB/jT1TmKWxHBHhmqpn3HfF5aFfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4tYEnuMO8lPr2QG0Yk2FFjNHpm3YUDu31ptIxJ+Vac=;
 b=BvuFaWNJOZ0wpZqrwReNo7zde6HPxGuziuqIFxf8OnHFP68uM30esaDZ2ObQHi6F597snX4hnDYzOVTsuxSaho/MyTzcuYAR7iFkfKz74R9CrBQksjyf+yJO8qim7kf/hG6VUh07CXiqwshttyrqVlRLatrlD0SyfJDKCSjlbM5uVeWjNr+phP9CRtDDWSwdDAn+7jw32U3O0la+gDvIgjRr+t5D7+HHhuMegsOQrVaTyy64OwHwWTEdVrgKMEaSszkNTLQPLyVZ+RecJ1S+CzZZwY+0C2nSGv/dmTAabVtTlkXQcjdKVWdL8Gz1dwmu6w2MSTfJzcnrCwG2EGumGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7738.namprd11.prod.outlook.com (2603:10b6:8:e0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Tue, 7 Feb 2023 18:23:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 18:23:57 +0000
Date:   Tue, 7 Feb 2023 10:23:54 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: DAX system-ram usage by the kernel
Message-ID: <63e2973a2af40_10757e29420@dwillia2-xfh.jf.intel.com.notmuch>
References: <DM6PR18MB2844FB8086757984EA312AE3AFD69@DM6PR18MB2844.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR18MB2844FB8086757984EA312AE3AFD69@DM6PR18MB2844.namprd18.prod.outlook.com>
X-ClientProxiedBy: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 502ad370-44a0-4547-74dc-08db093879b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfagOG4rSiV3qWBkRkEkgMG3ua3SxccyWm0l6lrpk9wYZqVma0TgobO+04qjKDiK+1CYIJW+bfuVShGyuT1vKXst5m2vTDBUMTskKrQHN7OgynDELkJKdHJ7G3kW/ji7l6a1q8z0QnocuKPzV+BQe0oh12SrhogCaFHi+/VVvv2JWexB2Ty2KYPJtRIHXWNdBVFeQZ/a1USgaUGkPXb0kvfglFSj+iOytyxhcilEJNkl0CKC/jOKjeuu/xtnHsIkunjXMj0OeHd6+WGDMU0d7OhHeX5HjKlNeQugcI3wIaMiPZ+yf3co4eWsJEr6hn0YAIigyhXeyqGAs22MPl0TKLnd5CJyTg/z7DHY7UE523rY+LdHHXEHC4OdQYMV+GTB+Y3b/Pz91msmEQRR4e7Vsfm+79+TxdmKGnaYUq592b4ZuDedT5RjFWaZenInypuX4aqM9sQPwK/Z74Gz69SFInU37r3ZoeesXcgMxEs7o1RwXVxRKWw47mdP1DAIUKsFte95fkIKwsgsJvVLtcEtojYUAVdyaupD1XRjuVRqVvzc2IjeMb2q0PGEDSfICXEBxT71WFFijynhOqHBx4rc5e1itrBvlHqKJYz8IwotT04UBELOxXuEb7n1yKZrECqnfPrQFf+tAZUkM6mlUrv7Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199018)(38100700002)(2906002)(4744005)(82960400001)(6486002)(86362001)(6506007)(26005)(186003)(9686003)(6512007)(110136005)(316002)(66946007)(41300700001)(6666004)(478600001)(66556008)(8936002)(66476007)(8676002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MZpJFR/cKDxBVfUfwCj0owNr9jarQhcQC+elYEZumP0fAc+wZdOOpvHZmL?=
 =?iso-8859-1?Q?OaDcq8A6+Vm0tVZUIGX0PjuGOCGlKawarkKrdgjXTtCbjUR8wnPbVPC9h6?=
 =?iso-8859-1?Q?EfngRtV4Yw+R3kxvsLA+U/5ut9rCp/FX/3RV7J2xpw3d7DvMpNj9byb3Bl?=
 =?iso-8859-1?Q?AWnhPAEDJfQYdJU6MR6IQjuccwh8FV5icQVq+d24+SgEC2sEeaDRygrUW+?=
 =?iso-8859-1?Q?BPmth4TbNCjckh+lrim3FA8T4dRrkj2/8bO6tdTi6zaizNg+XCtfKTUA1+?=
 =?iso-8859-1?Q?L+MGZVPrqOQdM/cKxJ3JrFzt/6+L6KUqQoltpQXMR/q/4WDP0n69vYUrI9?=
 =?iso-8859-1?Q?QatXQLwYi3hWhRa8A54ek1HbSAQ4cVgNAr/R4j0XlMy2J/bceSHthPWH90?=
 =?iso-8859-1?Q?jFNSUSk5qIWD+9IHvBV9R9qWc56mvTHn/OIRjK9oF/lXbmfc7bz0UPgVfw?=
 =?iso-8859-1?Q?n3oiU2xqiFZdwkl+hdURKgCT3N8wqxhvZJw6CWKD0yes/LPKT1rzIW1iEo?=
 =?iso-8859-1?Q?f81UsJFvi4xa8BiHHK03SJgBjZRa10kXEHMqIzbk10L6LapZDPBa77znfi?=
 =?iso-8859-1?Q?C54ftnBWxfLjS8hEowmAPk7H24pN7Uy49xKHOZ/loCDZHYiP4Mko6/9ykS?=
 =?iso-8859-1?Q?tpMUM+SCMMipKw6szwQ0xVkP5Kgfgo6f8hCZDKFcLEXs4OlKvDcSZMHWnO?=
 =?iso-8859-1?Q?288nnh0bIymNrOJJboT3Zrlk3Cizja5r3JG7tveu4SzGmmMe5Z4vWRQjh7?=
 =?iso-8859-1?Q?xPkKZgd4XZV006a6i3KlVnvtRfhMPzt35j8dYsaxMHAyACjPtHz2EuD8aI?=
 =?iso-8859-1?Q?1C4N7llq8BOxeO98fhhMpSD9m12yavoIslFZPz7/n2yDzIHjAtrpy8qppp?=
 =?iso-8859-1?Q?ey5sBMnzj781CatyE1yraTS2n7c/jdLggP4edUbnMlDEVIL5q+yYG3y/5t?=
 =?iso-8859-1?Q?D6xM3lZBvp1k3pJN9Ux5TAVTbemL3M/KZC4jr19Jpqw11gYFsYjBosZcS5?=
 =?iso-8859-1?Q?L5kQ4ew531qT3Cd8GLThhscIMkAuMRiwJC8zSIBG79xLonN/RSwWWsPL0u?=
 =?iso-8859-1?Q?WDv0L3iCFuQWGKdO359idnq29nz+C+NrM9Q8/SJq9QHIDcOfKhXYQiSIdn?=
 =?iso-8859-1?Q?YYZmIHVkui72wnyTl4+r6xk1WHblKTdrDEwLnKzxQOdE2o2yNWdvAKHQQn?=
 =?iso-8859-1?Q?zAAhDR1to8cB7VonubDeDQX0kH+IFFCL3mg35OUTUY9rttVyK21Ira/MSC?=
 =?iso-8859-1?Q?tF9CCmKKsrylbrflMCMmWSvDjxVh01WpTqt1NcgTF2Mq1dsZz/WWazFaZH?=
 =?iso-8859-1?Q?wZiih1Ogu4f+QLqLfM+CPENaT22PZZmolAlpm26cQCerRK528Oj/J9A7+s?=
 =?iso-8859-1?Q?F8vY1cdB9UF66AxQtpl94snotsX5dLfvyq8mkURxUAbXyLZt20qMMmSar6?=
 =?iso-8859-1?Q?bod/KTf9I/gf0U2GLPdVWwQLONpNqGw2/Tm6E7WwEj71OTvaBHMo4ArQR+?=
 =?iso-8859-1?Q?BSqUPrQmqXGZ8EB8UHQUXrxj6876Lwz4YoCC4wwQNVn1IGGnhrBvZCVKOX?=
 =?iso-8859-1?Q?kIx+Hy9nV4LUazePn8Wc3axc4havZ29wRJxL/N4dIFxUkAxhOs2Iwq6QdF?=
 =?iso-8859-1?Q?lBTaPf25GGdqh4XyUM39ETM0Dfm0BLLKfc/9fc4ny89K14xt0888JefQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 502ad370-44a0-4547-74dc-08db093879b2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 18:23:56.9489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM6sZNewKpWx38ETmYmgCs2vnrV9U2Fk3+fy608TCAr/+2FM/tzFqBUbeoXrcUdF8gC3S4IHrRejfRlWL/pBBKDFHHroDcN22/lRmtMNq4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7738
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Shesha Bhushan Sreenivasamurthy wrote:
> Hello All,
>     When a CXL memory is assigned as system-ram using daxctl after
> boot, can kernel allocate memory from this memory range which cannot
> be moved and prevent this device from being made offline ?

Yes. Even with ZONE_MOVABLE there is no 100% guarantee that Linux will
not pin pages in there that prevent removal. The command:

  daxctl offline-memory $daxdev

...automates trying to offline all memblocks associate with $daxdev. If
that fails it means a page was busy in the kernel.

If a configuration needs hard guarantees then memory can not be onlined
at all and must be accessed via device-mappings.  If the configuration
can tolerate "more often than not successful removal" then ZONE_MOVABLE
targets that. Note though that there is a ratio of ZONE_NORMAL needed to
support increasing ZONE_MOVABLE. See the "auto-movable" setting for
"online_policy" in Documentation/admin-guide/mm/memory-hotplug.rst for
more details.
