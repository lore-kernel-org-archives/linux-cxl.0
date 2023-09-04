Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BC5CA0FE2
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbjIEQXu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354670AbjIENZm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 09:25:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F841A7
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 06:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1XuxmS2aHSGaamh3GrqMPYuZLhZMYq9kpxLFKrd6uned0qFzH6P2Gq0CzcEhI0ZUmEbjfR/3XpR5/DPuoLBVmxsQneTYjtNgHkGSR1I0wbshIcKBohIPhubusliZRIWZ+XJWZpaCAaMn63q3CgEqox5jtov6FxsR465AO9D/4TicxKMfxhaDO5Mfw3cX929qOm2/govS+bkVNTTeO450i6fKwmVdA4Zjaj77SeDn/A7RfMlfzyZeS0L5hnTc9qCrGjaeA/ebiC6KPNa8WfvzB3lTjlYVUK2Pv0LGfJGHbURJITis51gF2u3WDyfLxUUT57Kc7Tc6WeA8Ngf42uKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsdaMF8FnZEmxyveiekJFWIwkuzJ0MOvIQFVJKEUrv4=;
 b=ghV38M4OE/9j0wtp4ZRS5Q266tDSqbJx8R8XrnbM6xwfooskbV1IXt38nnENGxXVbPKvpoA5Tnd7bkxIu4wHmw9DqIntJa5MQQGRO2JvJuTcDHsItfa04tZBnAsdoogl2/tlefBNthW5u1seizd72yKdR62FFvti9Qx9U7QFiAdoHKsYuvhteVjsOqpca8xlXfSKAJJ1XS314XfH4JhnPfO+ZnH96g5Sp90t3/q3N9JWS5der+qhUDCJuGZEz0+Fb50S0QYzsnP55QHeiciKTnzJR2S9oj57Vq3wNE3aqj/S1aLvcowf3n9hUOX/jVxR/2GYzS6b183JP77ga+RhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsdaMF8FnZEmxyveiekJFWIwkuzJ0MOvIQFVJKEUrv4=;
 b=oIaOLmvhEm0FBTA9b5VNeshq8US00vXGxneC+3LkUoRgeHiNWZDKy2/DBTRL5+2vOu0FyE+Bmuw5szWBkgilDQJsEbFmTMufg2OSUEuaEKptzDl8RO/9JGDTmT9BYKLNv14iyheakGHB0WSX4woJscHC9zXNdxGfJxMJxkbJ6mQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SN7PR17MB6748.namprd17.prod.outlook.com (2603:10b6:806:2e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 13:25:35 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 13:25:35 +0000
Date:   Mon, 4 Sep 2023 07:01:01 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, junhee.ryu@sk.com, kwangjin.ko@sk.com
Subject: Re: [PATCH 4/5] cxl/type3: add an optional mhd validation function
 for memory accesses
Message-ID: <ZPW47STwetDqs1vi@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <20230901012914.226527-5-gregory.price@memverge.com>
 <20230904180214.00007e32@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904180214.00007e32@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0132.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::17) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SN7PR17MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f009a4d-e1ee-491c-01cd-08dbae139652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80rQhEWTutkZ6z4iycQp2GlJ5IZPOEcT3/PUK/NpkrCbnr4hyVMxLJHRz5IgUr6z6Za/7mgaFbRevZ71XbhsktjsT9bl4w7pgdzc4aKeuSvwSEopqpnQHF3tbQROtaTPXSqxlJoRvtXxoTFKlZJG9CW8XXw8AyBHzSidifeI0vqcSPGYBIGrHQonq77obU+7vi07e6klOWnnfcbwvUm3/xNhKhxEzLtQ3EcQT7/TG5ADpatl3cRwCJC6jVXjGoWxnzoN1C3kw41naPvEKi7JBLKrXl0ILMgyE/2RyfB0VICtA+sVHbL3tcj7R6d3U/aNwC3gXxBF9hREUC6IZQd3cuTK5f9NekARPYjAFhzced9ht+TsNrgGDiXweXwVaD3Jqe7kIyaC3zH6AEnz7TCInOM4J5qiZrozDTdzinNiZby43RJSFh+SQ4gDga6HrODUGE1c67KVLKtThrluKxt+4JrCWHRa5jrlEXHtfGbBZJrVlbbyIGLW7wShSdpWj+iCt4S7j1EI51nbxUFbmNNHOF4aNOKDelTb/WY/EaYEd0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39830400003)(396003)(136003)(346002)(1800799009)(186009)(451199024)(41300700001)(26005)(6506007)(6486002)(478600001)(966005)(6666004)(83380400001)(2616005)(6512007)(38100700002)(66946007)(66476007)(2906002)(36756003)(6916009)(66556008)(316002)(86362001)(8936002)(5660300002)(44832011)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gTzEn/tRUAyIvhIZwXi2rrwgImHobJ+QMqLPFsj6DeWHhFAyJw1qToGvRfDz?=
 =?us-ascii?Q?imUwZMs5tfHG70Rji4gVcgeONBimsQF3QwU6nnSDXlizBezK1eooIlTNqm+q?=
 =?us-ascii?Q?ntIBcBXQTDIwA7IUDb2aOfEzOLbZUoDzJvfqTct4RGmo3wA9nY6wHzxOjjyn?=
 =?us-ascii?Q?RT4YlwR2JGXnHjrQBgBRB9SwEsCU/tKcuurXvqZ72tE2Cr53U1qQqWPNVK9c?=
 =?us-ascii?Q?F7BGCgjgqixbArXPLZlBCU0icCQIRdztSqUo67H4qCW45F+nHHBTZ25LZ+Eo?=
 =?us-ascii?Q?BBy7luF5l9ARp39rIdHDnqaqKsq3phDs4SzR77AfhnvFoj7FGvxKyziRS1pe?=
 =?us-ascii?Q?rf0hyh4wXuFfyyOz+6+XEXi3ALjNGd75ThHxekTZrXWd8bOIxOEkPQmAt6Yv?=
 =?us-ascii?Q?BFZ+bJ0+kqL6BnLxUMy5pUSyE5i5fPBmo7+naV5+zVKqnWwazNqTeMpyagji?=
 =?us-ascii?Q?fQb2rCUpLzzYn+SCmquhRQOOt0TynFzG0zUxGlbvWdi0br3OUoe+yFJEv+j3?=
 =?us-ascii?Q?NZKo1CClkfM31FanIP+MjdKqpR+6btsXbERX8rhwNq4a6Bs0rebCh4+bCEdW?=
 =?us-ascii?Q?Ruzs80VxVcJ4Sc2l8VuRRkfEQ9xLn/m0pozTsHbKu42fKTwmYZD/C7xB8FXx?=
 =?us-ascii?Q?xvcdvEQ2VnvJB4kCPi/i5xCaHMtnJpKnd1N/u6CpicyidYp6jSw6rWU7twtn?=
 =?us-ascii?Q?kVjv5XeTT3dmHti/9hjE4u4MshbPFpJPRtYmgyrkhxxd3QoBE7u27e5aI7ZU?=
 =?us-ascii?Q?bSQOJLNbkAnFTOg426DGa95fyiFxVOLg/3h9oTacy0Vsk4OnXT+6mzsjf+c0?=
 =?us-ascii?Q?bxFagYYeJ/Ay5AZsYUD5zSOXt6rkpW9zsNeUN2qrj0WsyppVVTjBupURvvKU?=
 =?us-ascii?Q?N1RykjanUpD1es4b3lf01XpeJNdxUjjOfNGrKBDnCxMyqMYoH9tQSNnT+xqe?=
 =?us-ascii?Q?nY+A++oW/gplNwmvR4mJOMEVIEtkUypmDe71X2TE1TWOz5Id23Voi/95LNEt?=
 =?us-ascii?Q?FsMk2AA5pKGhbKkalhs3KGbi4/3BNRbhQQHgCGWu3P0P0Qx8M2Pxw07g7gDj?=
 =?us-ascii?Q?InmIQhfmzbGZjOHzSG9PFOmGVwKXqtzxBf9Xvbi7+aYSD7EGqa/qGfo4LLG2?=
 =?us-ascii?Q?erJpjTC7+1sIUj93wqgpCqWLgZONpyR2xdwOEkYCEDIDYyRcdSr0jpD/mRtn?=
 =?us-ascii?Q?mEGaRMHBn8ACoiwK3rzhqVkVP2kuJrhCg/og2HxhKU4pevOu7r2rJ0mN6l9L?=
 =?us-ascii?Q?hC/llB+GYgVbL5ebl/WRo0P53E9JRW+I/vA45/jCalRY9YZAS12xym8VhOC4?=
 =?us-ascii?Q?CO7uNGdlO0oidNsPVQHe8+SAA8e5SJDpq+H95igsJcg/OCJpQfL7eYkteAOS?=
 =?us-ascii?Q?zG4E53rmJXwd+0o/ULpGQhus4dtjz12DOi4Db3R1WffF3u31CNcJZFc2UfQC?=
 =?us-ascii?Q?dNnaBNa8DJzhgYv7JB3M9Mu1BmJ2H+7cAL2yDcCFC4P+o+OsT7Ha4/NFztjN?=
 =?us-ascii?Q?94+W2fuvbMxssGveJobXdOb+72NFv7Xv/jdHCF2338c4IqywHAg89IYgBmR0?=
 =?us-ascii?Q?b1MqmnNloYH/r+JVJEuQ0Yx1LLF+iLriSoEeJej0uFrktObYovF8/ODxL24o?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f009a4d-e1ee-491c-01cd-08dbae139652
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 13:25:35.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQfsDl393nHpplMTee/KQzUrzrG2xAEroIG6WCQlD1gD7yyqNhnP1GyfyYiAh9ckOKUp6zrN6KjwipCJ6plkqtLq0R7RbR+FBRNPQ+mKQ9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR17MB6748
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 04, 2023 at 06:02:14PM +0100, Jonathan Cameron wrote:
> On Thu, 31 Aug 2023 21:29:13 -0400
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > When memory accesses are made, some MHSLD's would validate the address
> > is within the scope of allocated sections.  To do this, the base device
> > must call an optional function set by inherited devices.
> > 
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> 
> This sort of callback addition can be done via class initialization.
> E.g. get_lsa_size()
> https://elixir.bootlin.com/qemu/latest/source/hw/mem/cxl_type3.c#L1494
> as the callback is the same for all instances of the class which
> in next patch is CXLNiagraClass where you already set the
> PCIClass callbacks in cxl_niagara_class_init()
> 
> You can then use something like:
> CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> cvc->mhd_access_valid(ct3d, dpa_offset, size);
> 
> Jonathan
> 

Will make this change along with a few cleanups suggested elsewhere and
a few boneheaded mistakes.

~Gregory
