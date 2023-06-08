Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22AAC7EE25
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 18:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjFHShP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFHShO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 14:37:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D3819BB
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686249432; x=1717785432;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=4b1kkBD9U0pp60I8oGQ1Hhyech1rk0YrlToDZ5w8lxo=;
  b=P0GKtlnrbI9xE+Hw3pSvTGy+29RqyeAZvXa6DPbJBB6jrIhARZpeFdcO
   aC48rxgNnMa7sth3LySAxYn0tMVk/XkdbKCCBUzPYG8oTk4bQ/cA2QM3L
   RFvPESUO+3sHf3Y2Hlam39J4rDafa3eueAwY7aeME5Qe0LAm8mU4HsVUa
   qiLuWwPkZ+IOhafblvT2c8LFTfEXcgFT0j7biJt8m2bHk1faBA2gW1ZyB
   YHak+njSKn5iStpoZeZeJ8E7x0u37hoVcBOacOEigZaQpYu0ynQN9nppF
   NS2rbmIvdDxNblTZ9KOAAOiQ/UA4JUnjpgOVKHlPy1b4NWf6OB6xVp873
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342072013"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="342072013"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 11:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713211558"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="713211558"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2023 11:37:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 11:37:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 11:37:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 11:37:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk9h93htMXfGK+0FoF1PzYJvhftjZtjoA2Sc/RM+0Gd+PI4AXBeNxO7vwv1aN5Pul68V4gXIhcfZgJOR2FzisTCNUS/LD7I8CuQ/lxKAJxyCsg/VxjjOQwj4jX6FQQICZx54Hd54bzdGZ5A3Q3RH0bgVBZUPdm29tFjn44uf8qWgVgKRQJyPzXvIXF9tbVHDIDPnfSo4lWLcFG7DgAUcSbsAXOFvnmjB2an0UDSMXZu9kSNV2Wy4p8an47gBrTchYfVGdBXfY0V96PBoVecawTTrqC5aiozKI9M8F6PUElx6E9XNGEAhfthL0Sb5JF7vI4QL0PExfDbTYUCyOEPa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlJ0GwQT4BPvEkhKvnufjAQvMKe5PdeuiDcJG0/aHKE=;
 b=N06jssfSj7bg9HMs1UH64rYBteSVzDJiA0XgbZX0WqSFk6NrBt9qar25JJJE0EIbij5vCD5BVL+UpbD8uccVBaklEGCT4m5uJKKVQfTV0GyyaDPhz2IqTAZsrHAZZglEfPQEhy6aATeLnMMBk9bFwwRIU70C9gazpBKADvVzgEkTWuKuHo1ZEnVjxu/oXkodCRyM26L1nqjPEC29cmjd/gsHyGVHlhV/UqfVcOyTn1d9yDlHprxU647R+ZJZhGEyHX8Esu3c5rLQioctRzEpmh9a9PeAW9bIv5LSi0OkZ4WdBRrsYdw9y3dTxqAXD3aXb0xowatlQu2wW4S2xtR9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5439.namprd11.prod.outlook.com (2603:10b6:5:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 18:37:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 18:37:10 +0000
Date:   Thu, 8 Jun 2023 11:37:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        'Dan Williams' <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Message-ID: <64821fd31d563_1433ac294a3@dwillia2-xfh.jf.intel.com.notmuch>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646cf986dd030_afb7729452@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082A58633DCCB1AAC5DDC3C90419@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <TYWPR01MB10082A36ECFE209E4A05BA33190479@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <6470c6a44e869_1fc5429435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <TYWPR01MB100824F6720970B5968E1AF67904A9@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <647f73cf40c29_142af82942f@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082CE5542BCFCEF127CDD399050A@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB10082CE5542BCFCEF127CDD399050A@TYWPR01MB10082.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: BYAPR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:a03:114::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: ce80cd9e-ee36-41d1-986e-08db684f5e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59S0wSHasg11xRw+1vKl1GRG+tb+PWzIfkoXODiU3HHoSm3D7Wl8pfNQgreYbPpj77gi9Ti4tEzgYtk4Pj4llzTajc0QV2bCZ05fKAgWxcTZkR39F9Y+FjLojTEcR22KVqfRiqnrhDUVcFjICchzzTJOtJkpOx1v8EaMytl0yLKrvMgPEcjbruvsuj+eyltuwDSMS+VmmZ+L6pF8llay+jDNdWc/gQDs96Z1UV4gUKpsvPOQ8B8xQLMzrsPNN9Jb7QZGCssWhGk/MbHzxnAG4gu7im6RVpilHjhDIO0wNCYTSHNBAyYAWWp0XowkVns3SdRRqduubZHkZImHhWMlUZoDj/vSswkpB9jE2V5zSb464ao5QQnroD4NXXsbJfN4aEUlS8IwWLOyO9kB06GWXOfDHurwFHw8Xjdn+gvEOTU4EQ5HhhlacexunETohpih4W7V+Q7LPrgjMv1KkT3OpaFSEczBsaHjZk+xwViOGrDzY3soal+wqzGGFehtxzL1NZ4VA3h/wT9gOCpLf1IzI/PB5qnWhquIJZ/JLxBbm/ujbuGcDfwxXQj6rZMmp2+k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(9686003)(6506007)(186003)(26005)(6512007)(6486002)(83380400001)(86362001)(6666004)(82960400001)(2906002)(8676002)(8936002)(478600001)(316002)(110136005)(38100700002)(41300700001)(5660300002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GyEo8fO6giqs4HSI9NT93mHBq7VtwXT+yStLgu3v4Ts5R7gfqx/1/TKWK9xN?=
 =?us-ascii?Q?6Ezgrwva6Ea7O/1FDbfpXZARbi6wZBGEYB2k/t8ZkvlfJZZoBYMUlrqJTsvI?=
 =?us-ascii?Q?7bju6sBojX3hWmFZ38RZkFDXqWvQWRk9aFvQITBw+jj+YaGr6WrI1MWzogZ7?=
 =?us-ascii?Q?MR0Sh0/g1h0JLSiH7l3Dr8H3y4KLlnfmmD8jBLczlyW65tC7MaNUxzh8yCBz?=
 =?us-ascii?Q?+2vL3dZWlFA2MxWmL/AuX/+pYdCzIOdvZd7LdzPdfCep9gYYReNykF5iCrdM?=
 =?us-ascii?Q?GBDY6isJSKiEWA+B5fPJ0BZzMw/JB74jWaMKxtOZkY7Og7NQeo4rRe38qnfp?=
 =?us-ascii?Q?Cevfc6papv5JmxcikxHXbiiJpJgUPgrxA4RUk/8pMf60LetwZU5H3Xn0Nn0Z?=
 =?us-ascii?Q?prGx9ydFplT9y6mi4DoxLEoQC+P08iKkvA2oxybREQ2EcVW/MyGfasn2J4KH?=
 =?us-ascii?Q?V1EhWZ6zgYkT2e6mFKpCZadAmSsTl0CygdD2ua0phzh+2fCnZECqc4ylfxrP?=
 =?us-ascii?Q?Ew18fI4HDkY0a5KYdqETNvhvC1zk7V1R3lbfjnSvKpMiTteOGsqTsweHXFDj?=
 =?us-ascii?Q?ECEhYawadkifdhozc9ZU1ySYPp0njyrTsecbVsiYG8Lk9K9bvyAEgmjOJUIs?=
 =?us-ascii?Q?huqrB/sTAk/01rP6BK3/5cnvp1x1fepjRYPKPVmeflcl8CXd/+UOBfQUJSF8?=
 =?us-ascii?Q?l+m72Y4cNFVzWFZbCnndOo/CZs9wHnoQMCvXs/pTlIYacRh9Hpj8Swoz35Dn?=
 =?us-ascii?Q?ByGtJs4+fBRHDGEEjDhlSl3noYpEyy3/XT37LOj/ABfcE0B0yQ+STvlQZv1A?=
 =?us-ascii?Q?zAweBPbS+P82xUhrpu7M7j53hPs+BO69Y6iS5Z6ZqG1DFWLH8ttlQBLOf49A?=
 =?us-ascii?Q?EBWgspvYZ0fTBtOb8Yf2lgLOsSr8WV8+eqm146eEVEBXNmfQN/3Bx4zGQYI8?=
 =?us-ascii?Q?MCqyYxU3kCo0Nafp/dpBpJTIJU9gDNjgHrOKiEYBImcbwALw3cYIeaHyomFK?=
 =?us-ascii?Q?awnM1pZdKmUVlilXRbbtTyBMrmhn9LybD4D2SGvBUgFXX1ffwQwO7J1yx9rR?=
 =?us-ascii?Q?0T4dYxwNAoS6Lz+EJZHsY0Qa3sfOLB5w8djPDCkCPybB31GIom5+eJNMkJ/B?=
 =?us-ascii?Q?7ip0cxrQTIoFQPa1cVPf+MgVVAaHSmsd51wzZWZuii49bdnTG+bD+TOw8cbS?=
 =?us-ascii?Q?6FxjJCp+qVLEX2sULBxcGv5/UUGdYEZ7vmbZPZyJLsAOCVHbPeo+pODsJWsf?=
 =?us-ascii?Q?FV3Bvrv6Oz9ACgFJJmW3S1KJBx9yu9spaxx08kWqMqpv1tZXrf0GrawtDBiF?=
 =?us-ascii?Q?Bg1RUiPoC9qpRdayOFnKjV4eqZUj1wpbL16C5RJmqeSefTHIljdHgrQENYYw?=
 =?us-ascii?Q?Iy+Xf2aDAmfZTK6y9EdAAgPgLMlkcUzI8eoSG56YFX0mb54yDjmeSO+Hk+ei?=
 =?us-ascii?Q?6KzeLs+IqRfj/z/t6s3gEabrb5TDfWbETgB/y8PZy2Np+oHRtx8fSJUkO03m?=
 =?us-ascii?Q?beln4Xe/29QZL3IDzfr1PZdDv50LH423GRQar63hPwNQWReCGgQuII8L+Z3W?=
 =?us-ascii?Q?pcIb2r2P5DxSk7Bvczb3IZ15slxW9U8JzaYJIS0yKxqcmj2XktSYG+gPN2nR?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce80cd9e-ee36-41d1-986e-08db684f5e88
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 18:37:10.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vVQLdwevSZeEHBNAdvuTt4hWufZI5Kc9o8QEvzps0utN8S+K80enukt6b7rgLy8uUv29TJCGZSjptpNEAlezRydnVvZEPwQ0U1/LtYreiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5439
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Yasunori Gotou (Fujitsu) wrote:
> 
> > > Ah, sorry... My description of question was not good.
> > > I understand that PCIe hotremove is not suitable for trigger of CXL memory.
> > >
> > > What I would like to ask is "Are there any agent or daemon which gets
> > > a hotremove request from outside of server and executes offline and
> > > cxl disable region without users operation?"
> > > I suppose such memory pool manager (or others) would like to ask the
> > > agent to execute such operation.
> > > (Probably, the agent need to get the request by REST API.)
> > 
> > No, there's no coordination between the kernel and userspace when the
> > attention button is pressed. So any coordinated removal must be handled
> > before the removal is attempted. I think it would be useful to have a mode of
> > operation where pressing the attention button just notifies userspace and it
> > handles the coordinated shutdown of the device.
> > 
> > If the question is having a management API to trigger removal I am not aware of
> > any work in this space.
> 
> Hmmmm, my question is NOT about attention button now. 
> (I noticed that my quote of previous mail may be not good. Sorry).
> I would like to confirm what component/method is still necessary for memory pool.
> 
> I imagine that there is(will be) a total memory pool manager which manages
> a lot of Linux systems on each servers which have CXL memory.
> And I think that an agent/daemon will be necessary in each Linux system to hotplug operation
> like offline/online memory blocks, and/or requesting configuration of Dynamic Capacity Device 
> to a Fabric Manager.
> I guess such agent/daemon is not created yet for memory pool feature.
> 
> Here is my current understanding of an example of steps for memory pool. 
> This does not include attention button, and use DCD.
> 
> 1) The pool manager will request hot remove to a daemon in a Linux system by REST API, ssl, or somekind of
>    network interface.
> 2) Then the daemon will execute memory offline some memory blocks.
> 3) It will correct offlined memory blocks until requested amount, and request 
>   configuration of DCD to Fabric Manager.
> 4) Fabric Manager will configure Dynamic Capacity Device.
> 5) The memory pool manager will detect finish of its configuration somehow, and request hot add to a daemon in
>   another Linux system.
> 6) The daemon will request configuration of DCD to FM
> 7) The daemon will detect new area somehow and online blocks for them.
> 
> If I still misunderstand something, please let me know.

Yes, I agree that a daemon like that is needed, I am not aware of any
current work in this space.

However, I wonder if there is existing virtio-mem-like management
infrastructure that could be repurposed for coordinating host-mem
dynamic memory adjustment.  In other words coordinating a shared pool of
memory across multiple kernel instances is a problem that has been
solved before, CXL just makes it so that the coordination is across
physical hosts rather than virtual.
