Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA0DC54EAA
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 23:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjAZXyE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 18:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjAZXyD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 18:54:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAF1442D3
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 15:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674777243; x=1706313243;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4Api8yjojkYgOuJC2AKiZTNilCSd0gxq5kyRz8n900w=;
  b=WZmzrlsBY7/EL0M/lixf10v8dS6GaQCXHDJIaxQv28pfjDjtUp+sBmTp
   zY/kLO+akJFFvgMojdjkbziY4gE7ePlmLWnab8yNR+RW9kMRV+jWBHzsU
   J8gf+zug+0pHWBs0+OSSAtWW+jY14AjsbRr4vFndrtT4npM8VesJt7z36
   CLY5JjwXrjslZoP5tSwvJhooLCJYqpZo4E5G192XS9Igc1wNc8DLnN26E
   Y+U38KjEOKy/R872YaejO3HAPjE7ANWEmUy1YRohyFIlZn02GpdvI6fq2
   JcMYHBjh5bwAmEQKlOerN4tPPnRdrVMneINP0tTCYMeTfTHDl5dlz+7u+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="306641277"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="306641277"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 15:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="693529734"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="693529734"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 26 Jan 2023 15:54:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 15:54:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 15:54:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 15:54:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQxYc8d/+kg+l1reYVzy1327/68Jcp7foT8xrTrP5CYPGFApp5e4aSQHa1oB+knSWOlnve/vP0+b62qydYlhzuIoYcSvq72atSH8hSYdtlva1mkLi9mZp9xnA7MTazIi5eYsmiK/5mq05pdph1O8evCluQZVQXhkQvgox7hatbzRALVs6ohtIQx1+6i3SjH37xi3XGeVzUUtMHToFsukvFbWYkn6USv8yBX5H9Bck90ScnCldcYAJ14/RljMgp36M6kWHC0MVRhuIV7BcZrVpAq0vbXxC525VgifVHqWELnVixNOXBo3XY+OSV4y5NA4JoQ0n362vOQy3TorerpyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEUG1+eTY+WUbkExXcT5Sbb58MMIKX5zPtWkRELQI+Y=;
 b=b4XAaMTZ113bzmLJqGwuPJXVOZHlHe9iybYBo2MGCjS75VjlAyAkQUJNJ1J5lsaUT0PZ9e/LLhvHazpCXPwDEnjkUR0kp48WkO4+O0kM2fzUWEi7jZb7DF/7tsMrLFWIKoyAL9Q3s/7UGffCohm7Z4YiWTHwOW2+VQXL0ShVmMzbaSt0yXtu1o7XofBcUXaxzSBqLJgorbR1uLiGlMCYv5Kj4tREjib9cvbGT6ZbD7sjWUEodC60DjSB4UhB5j88W+6IyhrQYnbWsUbyv3n4U/JzimLWRabliYhuHMDRTIxmtrNpvsxZTNeAHTa6TKZofZWKwwhZylRYXvEXyk7eTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8124.namprd11.prod.outlook.com (2603:10b6:510:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 23:53:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 23:53:59 +0000
Date:   Thu, 26 Jan 2023 15:53:57 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v3] tools/testing/cxl: Remove cxl_test module math
 loading message
Message-ID: <63d31295517bf_ea222294e2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230126170555.701240-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230126170555.701240-1-alison.schofield@intel.com>
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: c77d4ab9-41d7-40ad-02bd-08dafff897fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUEt3s8KQl64Jc7MY2VpHDwjs4mLcE553l2PbhMklFivQHJ87J0sniMfYiNFetI9SQR+z4nSowrs0tN5R1sLf0qsmhOsXWOtZaMu7o4XnG+8qcP2xGOqrtfyO5Hj0r12c1vcrpHcRSSYwOXCh1wA/vgs8Sat2GJMx2aP6HnIY+BCuaHig6JrdhGGVIa10rQyQUoQlk1YeZAGn7k7ZNAEApF4SpGG/cnbmdjXC58vPaJw1C4IItlYvzpy4F+QFz1s8kRgDuI/FYboH9f/+KUfJEp16kFYfK6XSHhzIT0pJ0KfwYDGlHxS7PWrob92tz0QTXiBNfj0uJEj3FrP5DP4RNAKB52A1xlSJcfUVemIDOqBGHMfOf1MQ+KWQkWG7u/CSflm7U5HwxHxXPtB+SLLVDCY0p9vCs+graZH/L11laTDNTAX16qe3eExomz1IX+lV4LlL6Y3Ky1aiTHHIHmpZIR1DOpypnxfCPTUq7O3Rv0wLh/eWdMrBezox+Tw7By6v8wCm4hUSBOUfVQOVsOHR9dgd7Sj5U2JQ0zAZlupTlNAOAcqdv9vrtyrEQZyt3aHX/fuKNAidEJnK/r9zSJTnHOHiy7JbDpq1RidOe4uI2sb3SV2P6+DwGmzmzSIa7AwKLpMk0ht+GUsR1HcomMv7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(316002)(6636002)(110136005)(83380400001)(82960400001)(86362001)(38100700002)(6486002)(186003)(26005)(9686003)(6512007)(478600001)(6506007)(2906002)(8936002)(41300700001)(5660300002)(4326008)(66476007)(66946007)(66556008)(8676002)(15650500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/24ZepDACrVn0JuSkl+HdkNSWc8gEtRIPPUMt2jKgSV3SJZJRu5E2+QwxMso?=
 =?us-ascii?Q?k23KREQXQcb3BWCFTAwWHbNsvJD/WhK7zrQMfPizBWK4ffCoSCdRdUcQ1bk4?=
 =?us-ascii?Q?617/lsR/hh9loczq1BzMNB7rxOXjunl2Iq1ZaQWePMrHA+9z1JgIl2v0NMqB?=
 =?us-ascii?Q?uSMimWKAqL99mTPW73mu+Vk2FraPYOGVQNuPvYBIya4wTgprJkFjdtXzHjCt?=
 =?us-ascii?Q?HOWFq7QOI2TLzRz/KK7trVH4U/vezoKtoU6sM8QoBsQhZTaWWEvihmssiZDN?=
 =?us-ascii?Q?Gyr+/9CSEmkJxqvfOrySh4tq7XoKKlo8RkqCJIjeuoI8ejwG91ra9NPbg5kX?=
 =?us-ascii?Q?QxtLlQUz7p5AvPvolun9qQ/UZOMRcXigvLwWdlgdS7ZfqAxfDvoNASoVLTlv?=
 =?us-ascii?Q?IXNT6uJPBi/lxUYzgTRKCkeq9ets44IkQAx7GWfu8r8ClcPo/v8QY+5dco/V?=
 =?us-ascii?Q?W/o8lpeqX8zxHlkWwkSmwIj7hBOZXn41Z2qf4i79LKOhxzRmqVGUzWxETKKs?=
 =?us-ascii?Q?19tuANJ3Hu97Iamsb1hdIRuQ/Cq5gaoOZ59fHcy04L8oZjKbBvZpHrT66EhG?=
 =?us-ascii?Q?ZLK5dYbEsdGzGPQgwVjcY/gEa6RckNZK50Mnyx7of696w05yLj9mNC8RbTbb?=
 =?us-ascii?Q?b50wmz90MtpijhROgSFFcAyJoN1vLdKKjg7qo9tdIBtGLk8fHdwStss628SR?=
 =?us-ascii?Q?ekBxjqWWEpMd7xPEDRQ1rOfnXVsCuvLpnuOUp/L6gu9zIcPEz0mxQGXkEiEa?=
 =?us-ascii?Q?Tu7uFYxlAn1u84NERItua3mMere6/ITJEMlTGZeEU+FSOJq+fdYtCZcmow/J?=
 =?us-ascii?Q?+zjbeRspNiXWFt9np5Ho4OY9UToKcR4SV5K8Lsr4ZhbOw0CS5sh65dzRDNVY?=
 =?us-ascii?Q?nfPpA1+4iMaoVqigM88OI2BTSfF8juWDxTSv7JHR/ZAFS2wBkBYcS9R5F6PU?=
 =?us-ascii?Q?N87k1rjbTTOcau7yb7wbUHnAZ4Lmne6jCRESzkk41a9eGCs1SiZdSLV59He4?=
 =?us-ascii?Q?+LC3tRE19fY8eAGiPH492UOw+W2qpTNmdRNOepeIrQLt9Ed3rGFqIGnytZgp?=
 =?us-ascii?Q?0w9d7yuhC+mrdZpSqXuAby1ndhmRTJ/HULP7sClJGfIWcN7hHHpOl5dRLPQ7?=
 =?us-ascii?Q?z3aUvXdWModotzYXWGMeOXMu5cqW2gAoBiIgElZft7mUoLoYi8fLUAkAcjst?=
 =?us-ascii?Q?dGAEvDesalAdHYaF4fzw7W4KmNVzESrVR8oL48xdKJWiDeDcTWI3B7aHGK9k?=
 =?us-ascii?Q?gCS5I+Dclj0NGEwyiqGWFMIUpgr/t9HgOnIB5eDVpbE9VbhAiN1z0ceT7/d7?=
 =?us-ascii?Q?/zgr2kZZWO76zJa2v8+qzR3ILaEcF1loYfDhVYSRiRaGhEd+DnA7J4cZUc3w?=
 =?us-ascii?Q?u4bslDdrX0pvw+1DJjJ7qtNlu1WVl75G0SRrvUr8AVKNrKvGafnDhMT6UQuI?=
 =?us-ascii?Q?KOQ7ozht+sYSoVZ6q0RT+1wAiPvj7+wj3y4hoXXVdcERzAgdZE/kdWByVNOk?=
 =?us-ascii?Q?IKc088RPXOnLSxWicc1CZpQx1sedZOwI0bbmcWDhXPGz46oNwypVNmBm6T73?=
 =?us-ascii?Q?I/chC6S/6CVdPuUHTmQ4S4HM28t2VvhHXjfRp3PwaW+oHdmt6j18mp6GO7N3?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c77d4ab9-41d7-40ad-02bd-08dafff897fd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 23:53:59.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oUiVLTu+l+lQZTWIcq9Ut2unaDo9DhNhMsPhN0F6Ie1yaoRu1+qIF9oIKKx7GRyzDE+okM8flgQ3Fg5GAArWGae2PxdGxpnR4Rl4Ilkm8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8124
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Commit "tools/testing/cxl: Add XOR Math support to cxl_test" added
> a module parameter to cxl_test for the interleave_arithmetic option.
> 
> In doing so, it also added this dev_dbg() message describing which
> option cxl_test used during load:
> "[  111.743246] (NULL device *): cxl_test loading modulo math option"
> That "(NULL device *)" has raised needless user concern.
> 
> Remove the dev_dbg() message and make the module_param readable via
> sysfs for users that need to know which math option is active.
> 
> Fixes: Fixes: 7a7e6edfca85 ("tools/testing/cxl: Add XOR Math support to cxl_test")

Well, no need for 'Fixes:' since the previous state was just a cosmetic
annoyance, but certainly no need for double 'Fixes:'.

> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Otherwise, looks good to me, applied with the above fixup.
