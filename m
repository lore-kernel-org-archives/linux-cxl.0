Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80776C76196
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjDKRPL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDKRPK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Apr 2023 13:15:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3815BB1
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 10:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1ggglIGqHyhhtWFXXoC9le2G4khFd+YGPMMrEfWPHct1+ipXoXzTHSVVw3Zh4ZNCkxw1gfHAsAoHzRhQWb0DqHHCSYrk+7tuTl6+iFc5eB/ZaPZHCYbCq9nuaMxTLI0O82OrZF7/ub2AfH5oEFx1USfENA7FGWN2K3S3vGGQNTFVdaq0WRCekb5XuVSN6I7iCYU9wMMBDFR2flQ/1uEVZolurFHol52o4Ehf+rtwEA8Ur2LgLaAM0Fsn2BfqAzCoAjVUori5YaiYfj+W7vLKSjiegcVEvJ0WFmhcQheVGH/d4PXRr9Sv2wh3HMrkeaBHT5ggIBJceCWWGHpq4fguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqWq0boF1eLwvr5vBBfSFppTHWTEawaxdOho8hcvzG0=;
 b=Q/F9cWcEp+cT8wocQsi9mc9L3bftzzgftEHJ6CBeJ4MDOhKp7FE2HLi6ndZUuOM5VPtECKDlvokH6Sw35c7+/GayHe5p9md8LzmZ0G7FueplfstycQYBZo1+2dKyyFIbgiW+575GZhFU7zvIZqh8tyJ3U8tqMh8c80o1UOnGWC8fTLtZxX2I8fKPGTWTqG4HWsWkcPAQwBT6hqlpuuTTS812voMKnpNtddstK1zwAA/fkjvT/Af5EJOZ4VNSnwTJ83XvttcneZxhrOeSzO7t8oPi3C7qpAwBon+Y9H17OZ090w3qxLgz9J1WXXsJRKr9nHTc0SvvNhCFXINzMNxlog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqWq0boF1eLwvr5vBBfSFppTHWTEawaxdOho8hcvzG0=;
 b=IK9/1NpzuwvUeyhKsxyBYMZZQjP4p5NnuV3HjM8YTX8KzeP/u23b18JJVTOZY8iEr5enImtqvSdvnvc8dhWhVjpoxx+WVp3zoqbm8hihf7Kmy/4756XilOpjBbQa9uED/qmyKegodG4z+AmILika7G3U3p5Uv1k9X+VCRJsujKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB4740.namprd17.prod.outlook.com (2603:10b6:806:19b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 17:14:59 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%6]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 17:14:59 +0000
Date:   Tue, 11 Apr 2023 13:14:56 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, navneet.singh@intel.com,
        ira.weiny@intel.com
Subject: Re: "release early" preview of DCD enabling
Message-ID: <ZDWVkJKVThJzhMzM@memverge.com>
References: <64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BYAPR01CA0019.prod.exchangelabs.com (2603:10b6:a02:80::32)
 To SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB4740:EE_
X-MS-Office365-Filtering-Correlation-Id: 34524b7f-2ba3-4b29-e09e-08db3ab0476e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onS6U01SSqy2RfRTejBv5gM0ct+nISKis9oFUG3DqScP7fy/i8+ys6H/mJl+4qdUxpgr9uCyvvTcOtJH5WjkuUJGf9fMWV1GnlliJ9v2sdtRmg3TUillYGZNeSmgF/73/RGGHmqOC3euTOQ3w35FWptqaLMrHiqeK7FDlOHXFbmiSDPNXebzQzZWAiirNsK8fl33Dy8Yo1yupUCQ9RZP6Pz7R/jHTNog+oDy7qs1j4exVwwsPefZajrsFw/U4uy3RRslytFss9tjTktsldBc8lDf+l3hDZlGoR5tIWEXBfe0N9EZqDfOwJ46txfHdxn1V28nGqfZH2FMoNkXdJjc0w50svFeZmY1XQrrZrw5nUIf3wpPugtildmgQAFRLTHucpXAc3q0IxnL332AhmVME2xB9n26jKm2UR+/G23qiu+ZTjn/RvWc3njUkLRJ3KeX2NNjIflN6QFtc/nV0N9TaNJUQF/xNFw0dNvIRt6QorcsBkelF/dK4Ea8Y/iOkSaLUQ9p8DjLbfgt305EtP7eTqoNBDj7cw7QG57IITpuc/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39840400004)(376002)(346002)(396003)(451199021)(44832011)(36756003)(2906002)(4744005)(38100700002)(5660300002)(8936002)(66899021)(8676002)(86362001)(966005)(6512007)(6486002)(6666004)(6506007)(26005)(478600001)(2616005)(186003)(66946007)(41300700001)(66476007)(6916009)(4326008)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kjEjN93uVHbrCqRuudTNN6PWAqdZ5xcH8e++IoF2jXycZW2gY6duo6siJzcj?=
 =?us-ascii?Q?U33G6RUDxwjhAyPu8ZPyh0Tl6wIuKIjFJoR4CFTMb/5Oa9AYQZNYCA2qp0Xw?=
 =?us-ascii?Q?zBM7VYSm/YxzKo/2UgeQlNA63GreWKQXlNg4EDLQ0mPgnyUNa0VpAOKnPMbQ?=
 =?us-ascii?Q?gAwlzX+M8G8JF48xkEWb0jLFi9myM2K+zuLyzd526e8xkjN5czzbzyK9g9in?=
 =?us-ascii?Q?dQOTJPC78olT0YKQlu+I+3x+fe95a+/mohJxzu2ideIHBfjkrbX4n/UYGYSc?=
 =?us-ascii?Q?QNjoPwpLrm/oWTmlzmy3tscfYlY9hVS7d9bfkfZATuibtNJDQlflzLwFwm+c?=
 =?us-ascii?Q?Rtzuy/TTxo2NTN/LTx8MWKSfBrEMjXPHaxymwV/bbs5afB8MMyWW5uQzB1ju?=
 =?us-ascii?Q?MOl8GECOoE8D6io6Veaax7rZCbyXO83TB0f4wPiaZ9cYUlsFlufuZUzGN0Ho?=
 =?us-ascii?Q?DCL6oI1TiEZ0DjpLeyWw4EHLbPhjdAzM2NDQ0TLa/NIWW+oRb2WQJl9sk+LN?=
 =?us-ascii?Q?2Sk2QUB7jyErbEHLmSjTmuCWjA6q9hV0nunB8fTlcX0uTDZX3RiglJR6EM8u?=
 =?us-ascii?Q?BJsvuGhjWefmHvz7A6t8kN6VnSo1/F/nhu8VbKWTPLWBKv6iWjjBCkni8Rrh?=
 =?us-ascii?Q?ZCd46F19R9ZMX8t8QywL+5GQAPQ1Qo7fxxUzLbriqRFtLQoLVxldnem4ZmGT?=
 =?us-ascii?Q?4MU7p8MdOAyYP0ur4GKqKs2HVSX8zeCngXMW8fP8/P09gyIYiaPASz4eT9xx?=
 =?us-ascii?Q?kP9pQEPkMGvvWTgeiQhDFEZQEiPoSuRPRvmFvIUV/QsaSV9BQ2j8VgXNZEUT?=
 =?us-ascii?Q?JLUsQoKObk1niiI02GPZvp+eQcjp4wPJdgqhsA5Dhdo9jpSiwDjDCBn0yz67?=
 =?us-ascii?Q?hiljXuu2wYQbujXeYps1dsLph8Uff/l08z8xCSl0NOyuzp6Fvi0vz8yd42Pk?=
 =?us-ascii?Q?wT1eSlzbETgg/UDBT1J1TnL2OCfQiI1eCwmUjCdWWSuRHMlyXBFYQp8gisIK?=
 =?us-ascii?Q?62GBPxaUJ9JTZpQ60sFSVwGObul3//uuopq2w2ffWT6m68UBh7PTqnF2ZY2x?=
 =?us-ascii?Q?uPLTKPEiD9mvUv3GXtAbhIFhVk/q4XnlTKtqxAVH6wJvoln/3r2IFrB98GTX?=
 =?us-ascii?Q?ZBQ5nvm0Dg+NYcp9Xg1McjYIRESQLocg4QviKpzZ1OLdlEBK7rHwoWiS5R0/?=
 =?us-ascii?Q?ntomJwHgnjd3OyOn6Iqj6+6htOZngH/TWZ2U3Ye9626sqA4UkRMggOMewTaR?=
 =?us-ascii?Q?CRbG6zlgyhUDFcD8q3aKpZbZjkVWQtZRe6jO2wq9TRiNA3OTwryFzsJqB0Em?=
 =?us-ascii?Q?s7ZVdRd/c2zvLusixm65hD7CeeIRd8803fVlkE2d/09+tsE8FUVQCTq5uSVF?=
 =?us-ascii?Q?d6G+PmQSXJn/7XIByNZxzhSRQTAn+H3pE8CQcgFMVTOnRVqM7AwQvE80MYz5?=
 =?us-ascii?Q?QDdP18Z48B59xyY/8HDjek7IhvHPlY05PRsPLSDkHrYSL0yY3Fii2EnW2VHq?=
 =?us-ascii?Q?Ay3r7mpmO1wdmpKHWml3EtTq84jJu4cytn1vodAKVKqczXlcyF4DCmdrqdx2?=
 =?us-ascii?Q?5rGJqL3hsX/RkLeIYCS7RQl9zJ5hbzLHns83JlDOiz9DDhGBkqJJrT08QcJk?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34524b7f-2ba3-4b29-e09e-08db3ab0476e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 17:14:59.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maiQcOUEpnAZTqYmDeqVRCCde6WRTKwatzQ+f7WHyr95eRd8y+0hcKBUNutmja7nuN8q2MjKheVT7+6AfUgvkz6/vlIDjWKQFzOPLvPb2zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB4740
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Apr 09, 2023 at 12:07:36AM -0700, Dan Williams wrote:
> Here is an early draft of the DCD work that Navneet has spearheaded.
> Given the interest level I thought it best to do the remaining
> development and refinement of the functionality in the open.  For now
> this is just a git branch that will become a patchkit on the mailing
> list in a few weeks.
> 
> Questions are welcome, but I do not recommend a formal review until the
> patches hit the mailing list.
> 
> This has had some checkout on an internal functional model, I expect
> QEMU and/or cxl_test grows an emulation of DCD before this patchkit is
> committed for mainline.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.5/dcd-preview

Awesome!

for the QEMU folks, has anyone be actively working on a DCD device? I
was going to start looking at it, but didn't want to duplicate work.

~Gregory
