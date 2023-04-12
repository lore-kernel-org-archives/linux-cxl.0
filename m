Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C966C77B6E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 15:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDLP0h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjDLP0g (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 11:26:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E231A19A1
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 08:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX1RD087s0e6Ihf8MdOHi8nrXzrdoqpEKHzE4LfqpwfvtPOXnd4RXFNtGn6VzDBBr7h10qFyUtQv8FmKigYL/0WWa3kHcRu/1D5WL+sV2Ey3Q0DMBDI8vbGUFOq23gymfxG5/oIzhQSOu6Ztpf466CfhToBMbFBIP9h5cSuq1tkC8Z1swugbneHSPQqo0EWSyPBdYS+IVgOWSX77BcqvhaSsJ/HRoV6TJqN/8GGSAeeULbyUgpwLugqxveyyMZQt7PQgc2zbqUH8TvL6HGJHCP/37Tn9vxKvb7VKVrlWtR2HN/kvm6CxAbjyczjI3OOc5YRloRhjnNZu6TQu7Jff7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSs5XGFPjmoIFUmSJc857gbTWVpZEm/ycVLSVId3Rjw=;
 b=B8u8xNphE1gEjTx5UaKnMfu9YjH/KmydD2Mo3aMHiBgBE8GH21sunFPKrnvnu/NjuUF53NP3ntYqF4o10Y3RoFuN0RdceqjUUxSKSaRYDZDkSeWD2KAOtj8zJlP9ajovceQe1NtZ0BhUjokqvSqbY9WBbINjAMSftoWxpm0VtsOgEVpnUArLWVEPbxvQO16X4UNUQM33Aa3EIkqVJJl41AVbbDOeNJ4LXK14pLya8AZHHRMZkzZzn5xZ4VqAzCAuTtueIifnHF6eFrl+GJXwlraSPgVpot7MippvnVIbngmKQjJbpIjoWM/EeuLw3brja6ajRvNHsG6E1tQI8hK7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSs5XGFPjmoIFUmSJc857gbTWVpZEm/ycVLSVId3Rjw=;
 b=H9Kr8GZ6kkl0UWIr+Z+dOm2bp4HgMGxBpEj2s+Lt1GMWyF9C4VqiJCfkH9Sto1WdcsgLkKSiYur90MLBy2cdRni5jedKKHXCF5FNoLz/yzTiVw9yymCUSRYf+3cRHebLtSI3ASpHHblBorI1wcX+8qSe/4IA45ehEa7AedGHf/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4777.namprd17.prod.outlook.com (2603:10b6:303:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 15:26:28 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 15:26:28 +0000
Date:   Wed, 12 Apr 2023 11:26:24 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Dragan Stancevic <dragan@stancevic.com>,
        lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] BoF VM =?utf-8?Q?li?=
 =?utf-8?Q?ve_migration_over_CXL_memory=E2=80=8B?=
Message-ID: <ZDbNoNN0nkzn4xe6@memverge.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <ZDCv3lxLbquITy8M@memverge.com>
 <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZDV+f7+QH5W/vXAt@memverge.com>
 <87bkjtzu7e.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:a03:331::29) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: e016d97d-855d-4e75-3c4f-08db3b6a490d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bM3u5fWC0VViSjMN0EhxpY3xgPtuspKtkN43ozYDcwEb1aGJ3PFtVhYweHi0lVIFABcSWikNPi+eCsOKS6Ovjx3+kahhkBEJJpnshthMs1Jd+G1qA61VR9LdNW/44khGp2zJfRVwJqUwfylSAvK5fToauZXNfkK4EqEvt/dOL3NlSGeSZbbOcEP+aCAFuuFOQmUzIKo7oDFarVoJmV+fuQVlVPZCwlkOV9c/xi4oClyKVfUBbt9KnZv6oTfAHR3Jitg4R0WBNdIu7+U7B/Yn+SlFE1j2iQvmT0UgAuXHyb4Go6FL7RvX/UMLzW3DsXZOTYWza+ngQJKsoJoZo7G88fjpfZgkcG/1He6zzk8TLih3o/0x/mfvxmLtwY63WCBIFE0ZHUyHUgsB3cciF4BIcjsZbZht2/+S+3YkcSonY3F7XPY8ibZCcl76BV5Ea49otXdMnmMuRNnejC0c7/n2sa46RfVQjPGubqI8VMSdoBF/jHsqbaB/nKZEQthYrKIPokFPMnodc0qPp9cz7VEJxWvIg2TqVOl/uV3anuewlIOU+wl+GzCO6BDDvnyNw2vL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(396003)(376002)(346002)(366004)(451199021)(2616005)(6486002)(6666004)(478600001)(186003)(26005)(54906003)(6506007)(6512007)(53546011)(44832011)(2906002)(36756003)(38100700002)(5660300002)(6916009)(66946007)(4326008)(41300700001)(66556008)(66476007)(8936002)(316002)(86362001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zESlUvZf8vsH9q5gq/YgW64eGsUDFKNNFMcBmAUXYRR04Dfstg/YlXXoENT7?=
 =?us-ascii?Q?OYgnmz+eutyMETCN/NCLK4mKHoL92Q2nDWbSAH4PdyBUagS4+AzH4QZRGmyo?=
 =?us-ascii?Q?6aI6W/LBOnYwXpF0ztu8333rUqNw7yImRKTpY2GgvNtjBBko/m3/UYfNvnl8?=
 =?us-ascii?Q?BL0Tz7swW5Wrd9G6VEFFxpDJb3BdRqpS0Q7uNmDE19kvnpHRCYOHh9jkebMh?=
 =?us-ascii?Q?nAPzhLzYv5eRW7Y2sPcD1CCj6d/+fzmclW2mEbT0JrbMdrEXJnifgvwKPBWz?=
 =?us-ascii?Q?/qNoJNqRnDbea6KpyK9bXTYtOrRzqwWwZzxbd/D2SyxEcZLGeVIWK8EVC+w2?=
 =?us-ascii?Q?L4OtTFL47MWC45MwhZ29kPGuwdlOzGNIogZJ86MBo0MHMLlz5a/hS5NiYpHW?=
 =?us-ascii?Q?whAe9MSj1We5IvQO8F5DMlC7rkaLgjbVlQkFOidHO2bF6OGSw4nI53+ARPpC?=
 =?us-ascii?Q?YBGzRNTPRxrclTLwzcadbilLeLI4nkymeOuahFneDETjQ7MN2dIfTbGPm4In?=
 =?us-ascii?Q?/eL5zz660X6wOtSdzT5P3XNeX5xWLnGx9qPP4QB46fO1yLBrXv9xfASKQGta?=
 =?us-ascii?Q?PC8Vfke/Qh8fKK8btItWOJcX0dGTCz9+B5B2MpliAjJz1p4LsTvBZnHkxbaB?=
 =?us-ascii?Q?w0IwvdatBQ4J0i/A0kZejd8iIMJCi3PMClBhGs29o8yYzyErn6JMqV1kyI1l?=
 =?us-ascii?Q?naH4INjq1BOStAN8yfAsUyYMXIEu7Aw2Uyz2GYaPz3s86COt1i/WaBBp4Naj?=
 =?us-ascii?Q?XJ2KJlTeeEqg/gZQQb/uANfympNNy9jWtDIPQsd2KevpFjkptEphtKStYHGE?=
 =?us-ascii?Q?Bq6eP+lM1YjN/Msfl0M1qaeW8pJCqJ6fBmY5wyVK85x0mgRgFKplDo4Qq89m?=
 =?us-ascii?Q?zmQuN8rz80CRqDAUAJ5nx53/ojClGkNyRa0LJyEKJSQBQNtD8SxbfFt9877y?=
 =?us-ascii?Q?AqQsuWbtybRrYCANdmhjtv08mXmlyt9bFNJRiXDxXy9WDnuHFDh40syzpShQ?=
 =?us-ascii?Q?q03QWteL2Ql5pUaqYgCGzMqunKKdHcxpIShBVW21YZBSXH6mCpsEWcUCzutI?=
 =?us-ascii?Q?ygZnSaeB5tDGMYvDh0RGY2FCklDl2YLX3bighXDl/zS3ZgrEwe+eswYDfYZA?=
 =?us-ascii?Q?01bNa15liYOkG0KRiEmoBic0k9HZC8EydVFybtc0f/hB+6618qlMmzI4WVYx?=
 =?us-ascii?Q?YxtTtQ01JEaT6ToZyc8zoGLQtZsKDypMa6jcOxwhp3HLgbpU90PGncsoJorN?=
 =?us-ascii?Q?DE7AUX0/obBhGN6IFskq/GopwArRwsD8wUcBpLE4bZurwaPAd96eqGGfVNOB?=
 =?us-ascii?Q?2bQ8Mt6w0plMVPf3C1txRxGipPy/A5OcCnrF55IQTWOy9aMYIZekf7GXGk3a?=
 =?us-ascii?Q?q5lvbVfJniJH6w9U6Bzi+RP/e9C9XLD7+jh1z4ifmp0GTLNm7iG9jHdeOaUU?=
 =?us-ascii?Q?HMcM2jY/A7jlRwkUWbB4nUF8kzbhffdr8KhZAHvXnRdpX7HpvLtP/mP97EzQ?=
 =?us-ascii?Q?FWzDDQkfWRkV++jIHS/wqLlUbmYkpNLa0cC6eZsfQixA3DVX4G5lEL1CleVh?=
 =?us-ascii?Q?UShKDT2dO6ic4BHNc+43qLa5+pzpb/1e5qGBDEEqA/XNPfINOMPZDQd/c7kr?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e016d97d-855d-4e75-3c4f-08db3b6a490d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 15:26:28.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFgDb3rgIgjr/jCqmnNoW0gJQcGH4VfyHfxoUZw13rB5ftRHWsQxdNZakRbcv84L0t3eV175ndDV+9+0uNnfKbwVnM/fd6d604ryRF8/fyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4777
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 12, 2023 at 10:38:04AM +0200, David Hildenbrand wrote:
> On 12.04.23 04:54, Huang, Ying wrote:
> > Gregory Price <gregory.price@memverge.com> writes:
> > 
> > > On Tue, Apr 11, 2023 at 02:37:50PM +0800, Huang, Ying wrote:
> > > > Gregory Price <gregory.price@memverge.com> writes:
> > > > 
> > > > [snip]
> > > > 
> > > > > 2. During the migration process, the memory needs to be forced not to be
> > > > >     migrated to another node by other means (tiering software, swap,
> > > > >     etc).  The obvious way of doing this would be to migrate and
> > > > >     temporarily pin the page... but going back to problem #1 we see that
> > > > >     ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
> > > > >     troublesome.
> > > > 
> > > > Can we use memory policy (cpusets, mbind(), set_mempolicy(), etc.) to
> > > > avoid move pages out of CXL.mem node?  Now, there are gaps in tiering,
> > > > but I think it is fixable.
> > > > 
> > > > Best Regards,
> > > > Huang, Ying
> > > > 
> > > > [snip]
> > > 
> > > That feels like a hack/bodge rather than a proper solution to me.
> > > 
> > > Maybe this is an affirmative argument for the creation of an EXMEM
> > > zone.
> > 
> > Let's start with requirements.  What is the requirements for a new zone
> > type?
> 
> I'm stills scratching my head regarding this. I keep hearing all different
> kind of statements that just add more confusions "we want it to be
> hotunpluggable" "we want to allow for long-term pinning memory" "but we
> still want it to be movable" "we want to place some unmovable allocations on
> it". Huh?
> 
> Just to clarify: ZONE_MOVABLE allows for pinning. It just doesn't allow for
> long-term pinning of memory.
> 

I apologize for the confusion, this is my fault.  I had assumed that
since dax regions can't be pinned, subsequent nodes backed by a dax
device could not be pinned.  In testing this, this is not the case.

Re: long-term pinning, can you be more explicit as to what is considered
long-term?  Minutes? hours? days? etc

If a migration operation is considered short term, then pinning VM
memory during migration deals with this issue cleanly.

So walking back my statement - give my testing, i don't believe there's
a reason for a new zone.

> For good reason, because long-term pinning of memory is just the worst
> (memory waste, fragmentation, overcommit) and instead of finding new ways to
> *avoid* long-term pinnings, we're coming up with advanced concepts to
> work-around the fundamental property of long-term pinnings.
> 
> We want all memory to be long-term pinnable and we want all memory to be
> movable/hotunpluggable. That's not going to work.
> 
> If you'd ask me today, my prediction is that ZONE_EXMEM is not going to
> happen.
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
