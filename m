Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC74C1550C
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Mar 2021 00:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9896064F0B
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Mar 2021 00:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbhCDA7X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:59:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45210 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387384AbhCCT6X (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Mar 2021 14:58:23 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123Jn9qe071091;
        Wed, 3 Mar 2021 19:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=bJimN45scXE6L2VD23s1lt2rZtFhav6ZkpmARH6roFY=;
 b=NH+y2jSzphhkIPIyEW5k2q1KHIwp477UmRtA1JV+Jk66W422fVbk9x/33BDthQeTbxqS
 HuBG6sSEOgqrHY8cvGBBq9RjZXlPsrVlp3knJc14IQuzmq7ZEep7vOFLsXz2/gKkdrtL
 EF/MJJpck1dMhdrAukcDsYa5lxRpakBpXTq5nUyGUKtCIiEc3L3O2ssBaAg6PLDJcPHw
 pXMUfKpHfSc9YbcN19z8jYkTeFoZLJnWGa8ZpCtLpnAXmDxCMwsx/6ZARBL/U8vyOm4I
 00A2mrz8u0ZOWhX0gZXkGSC0PpkhPrVu4OdzHm/MlyZNkinzmFvDXyFczVpGhHr5133v KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36ybkbcw6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 19:57:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123Jp5ev131819;
        Wed, 3 Mar 2021 19:57:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 370001qngx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 19:57:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUY/MeroiDpFI08wb7wwZuUxgq+mBlEbHz1rlvH6D/jSyqbL3jluTGEnlSgL3DrVA7z8q9AwKvcveviLVuykGS/8IFFmV3PkPNK6Y4BPufgw1x4tpq8ZpYRjkYZDNYq75i71wd851/Yiwo2YV4xHDNjMv072kvUMobaxWRqdg8UhWeEWVpeEXBlOtZfefStsMgG5md8tog9X/bmWmjZ2pXt6eDgtRnK0ihAzjC37o84sYL6uKVhSiI3oOcKRyb+PcV/pUunbPWAO6257o9SsYVLYLkTainoSYjgF3y0tywbqXoaWpyJETQbZs5rubuUk3/FWAZt7005Dr7F4LZSRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJimN45scXE6L2VD23s1lt2rZtFhav6ZkpmARH6roFY=;
 b=dbb0DajRXyriqcwhp0Yj8X0Mv3iiawIMvAg2frDLQMvoL36nPGNrx1JdnI0MNDlSWbfceVyU4HYdNTcdCGOUZnSu48oez9jkoJGT0znnsYAjP9Q7Y7ulxMYZfDEdPkOMhGzDhsJ0ZRrz8SPET+RGI3Fzqx0qFDQ3etJEQBI2txPA5CBAlWyj77vBXQsM2rQ4O4PPi4BEcAEceLG/fF9I37757XRj2e4vuzqckcswc6nQSjJYx16ernLhJj/hrLYPb4T2F1YtLd4S3B0EsL1XJfSyeHw0gt3m+infArfoB/MpTqKBWWFyvYahtNeQ2qFUr/D0a8XDbYiDQXHmRV07wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJimN45scXE6L2VD23s1lt2rZtFhav6ZkpmARH6roFY=;
 b=e902c25mUs2Zi/fAGahpVZ09gzGjrNxZkvHrgLOncIEni50KrSlHccL1Qc9iYqKFBXGHNutIy9cL0+fQOCJJzyP3RiaHM57/9JKkhndPyG9ZzU2iR1GWQqb6n7YfrZKnSsfMquiB4bfEsjIhdB1vlg7LnXIRv7UTRsY/Iz3IUs4=
Authentication-Results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB3762.namprd10.prod.outlook.com (2603:10b6:a03:1b6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 19:57:34 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 19:57:32 +0000
Date:   Wed, 3 Mar 2021 14:57:25 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "ben.widawsky@intel.com" <ben.widawsky@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl: Make loop variable be 'i' instead of 'j'
Message-ID: <YD/qJZql2Ti0ULdT@Konrads-MacBook-Pro.local>
References: <CAPcyv4iXhsOK0ZdHuHkQ-FwZbvT6H2M+FHRoZVr=Pv8SUdpT+g@mail.gmail.com>
 <20210226211656.46359-1-konrad.wilk@oracle.com>
 <9c4643b7200449ce8e6693e4bcaf24b6@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c4643b7200449ce8e6693e4bcaf24b6@AcuMS.aculab.com>
X-Originating-IP: [138.3.200.33]
X-ClientProxiedBy: CY4PR01CA0014.prod.exchangelabs.com (2603:10b6:903:1f::24)
 To BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.33) by CY4PR01CA0014.prod.exchangelabs.com (2603:10b6:903:1f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 19:57:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d27db5a-3b9a-4e39-8916-08d8de7e9511
X-MS-TrafficTypeDiagnostic: BY5PR10MB3762:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3762461CC5D414797337A21689989@BY5PR10MB3762.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTZukkhNxGR1FCB/jZSpMHtXSFc+Ub5DdNecsCiziawmtFKuCWTp9OVXJuGR9x8ICBmw5DyBpjlWBRCUyLbOHdeOb9TmvZ3fv9aXi7vTkihUIIHJrIMsBu1aFoftCs41oNWajMsA57Vpk0P/nL9G/OYvGv1+SKW4hL4L9rji4SQnWM7vaSzJ0Jr2RpUpyxVK8qXIh8DQUswatCYtjI20BfTZEPrBkeJRWddBiXw2gI3vE+Nh5X3javBvv98YJl7rdNVNni6+9L75rGoTa46tu+HpJ3tHee6P0CmtbE3HwbYGVEmPWUuZJRszgcAW20/ywS8/F2RdM2YXGOyKTv2h5WyYREKYfb6YWmL6Z3L9rzwSR7XEC+9nknX10NF+nv4kQkHlMhhC+c/BnBFn/TUezYwBW7KgXjnGXz/pODdglGY/liBZVlMTAJbuwJU1C8Zwah4eAivLZYqMUIoX0VBMk2ZO9oAgtj/Uz4c0Z+XiVVW9w851OupnqDT5wB3vcClrLT0VeL0sLFqtJCCcu+DmVmtMoTot6oN8/3BPlE5Bas4DyyrUTTgs68HD4ABFUSsGcMShfsFUbWHHeAlCfY+R8QcwVub360rtdtxC+gEfmCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(396003)(376002)(346002)(4744005)(2906002)(54906003)(4326008)(6506007)(66476007)(478600001)(8676002)(8936002)(5660300002)(66946007)(6666004)(186003)(16526019)(66556008)(86362001)(55016002)(956004)(7696005)(52116002)(316002)(6916009)(966005)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6t/nXbBHlQs1EFUrCEXKu7NGUga4zcFxK7jgJ6g30xCNYbA8Hk0s+5Kf+0U/?=
 =?us-ascii?Q?WSMgh6B5xZeHOtqV/HrPhSsKzEnOdrHqzPoExV8GqXQRXriH23Ktv9QcXWxw?=
 =?us-ascii?Q?5UhMLwuPszqhgx773L4IdlmOSkY025sKX4liuBKA0gXUAiGw+yOdNlbTDE3U?=
 =?us-ascii?Q?Cvc3fAbuhNI3B242ARnFhZeaAUYN4Ix1vKqBjxXs2F+Itor1ks+XQ3BWK8xr?=
 =?us-ascii?Q?CTXi1sz82a5UzT8UW6vcdlYKhgA6e2WZT5nvRtrH7pmApyEVaP0qUCeJWPxZ?=
 =?us-ascii?Q?g87o3rQ6sal3uQLFUdj0DiaH36dpjHPiFHlygJpSbWU+IeFcDjmmLyv1f1KJ?=
 =?us-ascii?Q?NbftdzKxr6MXBzsaB0jpI3+lg1BFeeZuyL4SkyLbBI/Bw0qGHiaJObAmYW8f?=
 =?us-ascii?Q?N+FQMpEVUUVGCI2EE78GIwO22/h9XUK1Kc4MAk6VImjS2Z9926NMtdcOHOBl?=
 =?us-ascii?Q?/t1jW3xjGSI4eWR0F0r9bAra+VLgeiIBmDCzDG6fSUvEEhTxhwylla5rLrOC?=
 =?us-ascii?Q?OZDhWbAdbD1AU7nfkzzDDWI9CE6ocenDGANohUSfmc731WLiCxtg9dbGK1Hn?=
 =?us-ascii?Q?0X1Eu2ve9HklzLEu8PUtdcPxA8P04R0t+takgH4sPc2KvbFo78JytSNiwP85?=
 =?us-ascii?Q?MQZu6PMc+vYtME3pd6Madc/XBi/yLhG7zVqQpACOw0PLv5yJvMFgQq3LtEnb?=
 =?us-ascii?Q?jB0RcQn5iY6GODLA9Ql90d6JFFgzI0k79wq2AP7i7otxer1RWxs85Ncbuvd8?=
 =?us-ascii?Q?jYs05hhmpuSF90PexuNKQ7xRvGOZTbMy6+XMhOmULzhkPPdztPILetKgCVZv?=
 =?us-ascii?Q?kTNkG8dQ2JArp54ASWSZfirjSRIfHmoxnVjKQ61JeHQOK/oO9qJzDEA7JhnO?=
 =?us-ascii?Q?sic/tbA64nX3R+SVGhWzUFZ1kSLGZg/mhK4awWFYcAogQZAYlIkkvhDNRXHs?=
 =?us-ascii?Q?T8joye7aSL5j9W6GcZuK4oU+u77BAHtHV1CxIOWpRtP8vAvEDH8Or/t0N1Dq?=
 =?us-ascii?Q?XtdPhIOBOGcg+q9uteHX+OvDmGGjJc70Vgpljq33g4YNPPavQw7UiWpbKNg9?=
 =?us-ascii?Q?9XBpyTfieEqh9amAKMttOeEYwNEPn8kJRNFcMJiDcPq2rDYb5ET8+F8+lJQ5?=
 =?us-ascii?Q?PJuMuaMq3w9iryj7u34NLfuu+Q9ReVONKp5aiajjBGpT02UbFA61MMaDTfLy?=
 =?us-ascii?Q?HWm49DOIO/vKxRNFIw3uknSmmCzT42238UAEylJmQmELfCrUzLFXqfi+Iv+O?=
 =?us-ascii?Q?E/+q22RZqd+DCPBP6bjZz7tpIKdQP3yCp7kbJztfnslYtVebI82fmpBojpX4?=
 =?us-ascii?Q?MuSnaiPhHUN8rMXvMlC0qDju?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d27db5a-3b9a-4e39-8916-08d8de7e9511
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 19:57:32.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ko3vmJ3X7DCSs9omo4GT6AgrH4D2HqmX9w4f7iMNZhxMf62fvBLU/BskAbiiUj7hCjFk2QlK2296Z3BxbfVnBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3762
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030140
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030140
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

..snip..
> >  	cxl_for_each_cmd(cmd) {
> >  		const struct cxl_command_info *info = &cmd->info;
> > +		int i = 0;
> > 
> > -		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> > +		if (copy_to_user(&q->commands[i++], info, sizeof(*info)))
> >  			return -EFAULT;
> > 
> > -		if (j == n_commands)
> > +		if (i == n_commands)
> >  			break;
> 
> 
> Did you test this?
> Looks badly broken to me.

I sent out the v3 which had that fixed. See
https://lore.kernel.org/linux-cxl/20210226222152.48467-1-konrad.wilk@oracle.com/T/#u
