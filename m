Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C4DC77B61
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 16:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbjD0QfN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 12:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbjD0QfL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 12:35:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1A946BE
        for <linux-cxl@vger.kernel.org>; Thu, 27 Apr 2023 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682613308; x=1714149308;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Lswcdvli6wid+J5m9DZneojdwZQnpJ2d3sm2lUSfkrI=;
  b=iZAPsVQoPJj/CgVRzvIGn4bLvDqYZ+aa9mv5hC7oJEn3jNVzVNTmFuAi
   iiRBJ1FbN8PqKp+viTwQnwCaqXaz2/XMtV5ep0syPdt7MTmU3ITaJ4gsR
   7wmizzO2ppH+s8fHZsAKY98XRemQn6Hpf5OcGNaRVUrcQyQoWfZRWHAEI
   P9eFGQtf7wTxOTQf/WoS+Siq1ccYhiXrhkkpRhRNzixt1KHXX44/W+5Og
   B2Ud+D4JWH05czKAbw5Z+/PtmeXCkd+tTUfcNVJ21JsoNl5+VvM57VUeY
   cPLP0B/B6nhLqH+fEXiZXiJ8ZKX9PXDibu6z4ySOd0rbltCYxt3iLW0P/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="433784770"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="433784770"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 09:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="940741122"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="940741122"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2023 09:35:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 09:35:07 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 09:35:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 09:35:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 09:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SedMwxm3GW2k/xRsnWGVc+aDDg4BSirmcnEpvqxeuAtVV0qxrBP9CtUYRmYEIepfmn0gWBl24zNGVD+orVGO6ImBJU8qp+/CAJhnZ9TiwujGHxOYU75u8AIQDOg9/84T/hkN88vV1mNKupSjNjHahcT5RL76OfNvf8ftQdI2Q8S/f6X9lBMdeheLqXPWRTVS33yzYLAh56l8Kr8OzoYay2bIscgwYXDaeL1R8SwccUeayzsa36U2N59+/2E8Rv9w5PT213Zvh21SS9rZlCFOJr8gxZ1Xp+ds7fjHYIf6R8hhXWUeRpj0KJIcd6O/3/ttdt4ny9dNqxwoPdzR04QIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU0Zdw7t9n7uFUCB+v+m0YE61dTeDQJ+4C4wJONgkrE=;
 b=f8Sz/VcxFlsQhH6BYVY/m4XBzQV+aFi6NezgRCgjXZRLN+UH4niao/BGc6IrAQYUO/Zza1dxfD6OzEyYSyfUUpRCxeGeULubnDhd99SLbNVPcHuh0XydFHT/xEvTaTfF0fG3DDVarZmmzZQa1KV7PPa6ZEy0yVImoM/pesyKOjgETDalxSNaLjtP3r1kyqN2/BAnJb33693l2pw2XYRaU1RlkfwB643GR8zNNTDgLu94uP65SUaEvmGbBpEkQ1vY9pXsKKbaWysPXQPG6ZFY5TXPMzdPGDMfwhR5beYYrjU/wgNU2tBXeNttNesZov3R8gDwgM2/4oclUm3iBwJ8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 16:35:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%6]) with mapi id 15.20.6340.020; Thu, 27 Apr 2023
 16:35:05 +0000
Date:   Thu, 27 Apr 2023 09:35:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v13 6/9] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <644aa4369184_586729479@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1681838291.git.alison.schofield@intel.com>
 <1081cfdc8a349dc754779642d584707e56db26ba.1681838291.git.alison.schofield@intel.com>
 <rjgz474mou55qufxwwmy3vpxftagdys6ge3iqs3guqukkw3jlv@ho7vuf7bmjsp>
 <ZEn19R/iusbbkPau@aschofie-mobl2>
 <iurygq7c3gg6gskfzgnl3mkr7trbpnp3bo6nzqiwyonzw2kscy@w5s3xh6fkell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <iurygq7c3gg6gskfzgnl3mkr7trbpnp3bo6nzqiwyonzw2kscy@w5s3xh6fkell>
X-ClientProxiedBy: SJ0PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e0c8f1-0f48-4f6a-1a01-08db473d5ad0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Khbe1JsFRH7J7xDvw0xmXV+9ADcff/HI73IYd1BsCvQaSA3/xokKdObAl8yEzzjBy9MD0qWB5HYuwiKeU+OXj8VvoftwUbLvvQgY2A2bHob9jE7VLB7foYL/RKb8aVe7z4/Qe2g5svvHFoQRTgJ0zK+HMIe3KuGX4YjMxFcJWjOuLOrZQTr5iFZw0SSweP+cgKGZnJllSua7d+bmnJmJg7bYqNW70FEAkZx4mna0++z8Xm6swRSEMfg8zFEPzTInnVTsYRM3/yCWN2TOWmJJBc+RITMJx96c3djKmpIEgbXBVQETyj7xkiVw9W3btWGs7VxAstdS/MT8sNvpD2VxZIcU7X+7BLhKoEFtgiCRlqOuf2IbVE3zbQTVT6r1JCptzKexqV0KTtQhn2sRHu9bSU8FLS3M/9xfJAFoXBBPwoQ75l2Fg0KBgpS1paf8dZFEH/InzKR5iRTAAhYRKbD+TQ18UEeAR+4rlXthijjuAXxHotxdudIGwDNoElo2rWmUuqPoqVpQJ8fgoAejCppR+SFzqOKpfIyZJR0jsOoCGA2wXwy61rwM120Zs2iBKM6d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(86362001)(2906002)(6666004)(6486002)(186003)(6506007)(9686003)(26005)(6512007)(478600001)(66476007)(66556008)(66946007)(6636002)(41300700001)(38100700002)(5660300002)(82960400001)(8936002)(110136005)(4326008)(8676002)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tcVmgXslsAMfZV5IkW/2TsVKwwfFJGE7AMb8sDyho7a4C4qv0f9wWouuH3Nt?=
 =?us-ascii?Q?9XwI5hrGE0/Nv/MyrMc+uHv7sgwYyBzMf8YyxUi1OwiVyqSlWqzPIcp+JoD3?=
 =?us-ascii?Q?1LM//LVp25UxWQc1z7MjWtPswSEWOAWy8xiRNP/NZqyfSUBgFF2aweM05NUe?=
 =?us-ascii?Q?LSoYxCG2AG1bZi1GW/aCBCyO5+6DgyuczWV3c3zHFxQ8dRT5crZJPqOBbVqj?=
 =?us-ascii?Q?GRDWvKO+CNAao8QMVtqAhjBC97CR7sEdTdSMn+GuDgGzSAkzpp2l/6VT++De?=
 =?us-ascii?Q?OtTEK1Z9MEvYeNgb3tNveJ6wmz09eu8qhZ50G0n7au8zZ5nNTam0bEI+1DI4?=
 =?us-ascii?Q?/UujSqXaY66dLQouOGcEk/vW1yRmXidlc/xrYrdAimKAvlIyuLmXyuA/LkAN?=
 =?us-ascii?Q?VJ4QYCFbMHdkSh4gBrDidx5Ch0bKVulpGca+ahMMirAI5wsvZJjw+t7tiV/5?=
 =?us-ascii?Q?fRqqxYbqA1XHFE5tXQMKaAtHw3s0Kx64oBRn9vLCaCsixprz4XA2fG0YEzV1?=
 =?us-ascii?Q?5brRubMRRQ/YEbuVT1S3e8ESBLhZILYQzY0YgG8Sl7PnXRDzdiObe/bzOE03?=
 =?us-ascii?Q?ssrGEkHuf5UC9Z6ellKlUUa75y0LSa80FdEGq1hujsLsvSOzwz8Yv+Pmeg3D?=
 =?us-ascii?Q?7P6WAsgeRXVCPSMrbgzjSVVff/nKUncD9sef82ntzRNiAcTWdTEGBbjobdvo?=
 =?us-ascii?Q?DtzrC5MlCaTCMj0+75K47t+CSfOEDGlfcqwFSmcyjtyUbuoG1qnjhgyCCVxT?=
 =?us-ascii?Q?vBBNLReDmyyFDByHNEnjc5Da5mJx+6/nBukR7BXTNIWMzcSQfEi3Pz06Mmdx?=
 =?us-ascii?Q?mFu20bcv3mckEquKbe0RqhTn+YDdoZiRrL+w2RXz7RZmZ86ImvsJVueWtb/z?=
 =?us-ascii?Q?0avw09w4Hy1WAMKlxKBffgdlll9id9YpT3Zi5aPrhrqQsSlqwFvez4X+PDIG?=
 =?us-ascii?Q?rZTP3f6hpb4FAUZNx9bALxDtlv1ONpeDTFhf80AFbrZUSuwwsKZu0oIK2Vq0?=
 =?us-ascii?Q?uSA34vWxWvvQ/JIDsjWcdI/0sICcArbIbCVJWKpkS/R8k1+4FQuFX3psRMA8?=
 =?us-ascii?Q?glhF8280MyOyLGDnzFprSG+Z4ddyogoiHSnx1JHbwzfviYUKG7ZPSDj5NaIa?=
 =?us-ascii?Q?+hGhNoX+hN1zSC0IkZ+JUSIiD+XbGvgkSB9lMQtmMb5V8G4M4qYYqSPVqdat?=
 =?us-ascii?Q?cYW7E7LD8Waufe4v/vymX4pOdPn97eQThFl93pXqqOb+RcXgY3DERXmUM6+Q?=
 =?us-ascii?Q?5WROZG5l18FGJBo/Q5XW1YU11a4CaX5FJvsvCc7Kq+WTumiCDwO2XbyalJhu?=
 =?us-ascii?Q?pMjFxnG3YvQaTCsLQHN9gPeb989MJB9RvTLi/HlT0ZUk+MXOyRfNg9tRqIRp?=
 =?us-ascii?Q?W5EgxcxoGu3QQZ4bhO2S9P9LtCFeuRTyjz9vQWdV4QsaNDCZW58v7/3yuaBW?=
 =?us-ascii?Q?Nbb1eGZP6KWxaFGnzJg0ao1iF8UzKs0glQqbXNS295YA68q2eZQVioP02Bc7?=
 =?us-ascii?Q?hDGMmDW+6iHbcIdJL/voXSrjyAXwoNkSOAwu+plrkuRjE9vErZp3V3+IrNbm?=
 =?us-ascii?Q?9ajr1pb2tjwnrqeZpe9uvspFIdDBC8oHilUfgfXdsH3bLw3f6Z38m7hfCX5w?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e0c8f1-0f48-4f6a-1a01-08db473d5ad0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 16:35:04.9134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+n/zv1chbtKNLq98jQY377o+QIxZZ6iJCPd+9pFWmkmeIxKlggLpsyd9JXMDO0DtmpQuXeX9skjse4HAPvaIBCWu+AOXU1ySaj656XJThw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5911
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Wed, 26 Apr 2023, Alison Schofield wrote:
> 
> >At the moment, I have 'trigger_scan_media' that results in a spew of
> >scan media results to a trace file. I guess we'll chat more about
> >presenting a _nocache, when I post for review.
> 
> I'm not crazy about calling the interface scan media straight how just
> because it's very unintuitive - albeit users that care will probably
> don't care.
> 
> >
> >I'm concerned that a  _nocache_ will lead user to believe they are
> >getting 'fresher' results, and to over-use it with that mindset.
> 
> Agreed.
> 
> >Get Poison List gives accurate results and Scan Media is only necessary
> >when the poison list has overflowed. OK...here I go opening the can of
> >worms myself ;)
> 
> trigger_poison_list_overflow?
> 
> If triggered and the list hasn't overflowed yet, just be a nop?

What about a "poison_overflow" policy? Defaults to "report", but you can
write "scan" to have trigger_poison_list invocations fallback to
scan_media on overflow.
