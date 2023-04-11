Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9438FC76196
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 15:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDKPgn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Apr 2023 11:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDKPgm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Apr 2023 11:36:42 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF52A1997
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 08:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq1vpSAd0rPKGpdbQbD7dtxfgwEGPm92l4CgPUqFV//Z7B7ANgjo7odywUfH3n0slWhPKipXqAwE9zq3mIFr0m5QqkSYKumTXCEAu3+yMvTohxB9N5so9tX75pTDsjQ3udLjGKw/97rpxxD9qfRzCswGcHKWwKAypKckliEBvJRRZx7rReuSN1W88Ofn6DsOwTiJ1m0z21CkLCuS6517btH6R3qbddB6M1HgTo7ONbnP5SCiwpmgjg22bMB1yLszYcHXEtOga+SWY2MlZS2z6Y5YpANVqnZkgBaa3I02MJLMpeo+Z2MegiOJjf7ClEp487UHJC437BkJRt+PXfhw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHzH2aHTThc6v/+yQWnbJKWfDBGQ2HUc47bOVknAe0c=;
 b=F53s/jmH1M0ho8B6CYL65VWvB+vTK2K7L5tsx12CBzDdPMKNisOlUlqE2bnaa+C8HZavd/D3hZNoyB5xlzIJcVf/4kQbQJj7sJV1llthUVSXHX3kyeyxtqLChE2R63Tw38l9qzwH9u1M90lQevB+KxcUJjX0KoPcAVo1VWpHoWjbXUnkZatM7z3Q0BcOgtWzCHA2qbSpiKFoE0D45fz6yEfNtG8wabje8TNY/te7o9fMcbi9BbZt4VZqttDrn1+CyQR3lZ9xeec/XraDp9a50S1UnNB+FphBFiMuyrusvfi+vUj821UwVrIMkF3/s62pGlM6v/0/hlAABSi39QIAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHzH2aHTThc6v/+yQWnbJKWfDBGQ2HUc47bOVknAe0c=;
 b=h/ZI1P0xq1RUksin5juSyDnr0Z+VTc3EOK38KL+bcZXY5dgfGX+iZnxxy+d2SsAAqwQNQzRmyKxI3reWkzoYGxR04Q/kF1T6nzZiggFINItGoQjeZhsHQ2fYokWbEmVsUy51yQ+JEvHcEhmUkgjukz/RT2OhjCqSmcy8IBpeIlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4640.namprd17.prod.outlook.com (2603:10b6:510:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 15:36:38 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%6]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 15:36:38 +0000
Date:   Tue, 11 Apr 2023 11:36:31 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Dragan Stancevic <dragan@stancevic.com>,
        lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] BoF VM =?utf-8?Q?li?=
 =?utf-8?Q?ve_migration_over_CXL_memory=E2=80=8B?=
Message-ID: <ZDV+f7+QH5W/vXAt@memverge.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <ZDCv3lxLbquITy8M@memverge.com>
 <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:332::17) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0f68b9-034e-4df2-ec37-08db3aa28a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1Ao6ZEpiTcTN0Yyu5m0H1SnGwjLT5GPkcIiXMNCYaacRu5Rj2y5RfsRL1kWgOoM1v3f0fAos0c6x6I21ePV3OfI9szI6AAtSVuc1C2IQnfB2oL5Z1Ji4lcZw5wQqMkI12F+J/KtVLo3eFMrxwF3WruCrGar04BQ+OohRfI9430fIGO5KTEzy9PvPkl42eqSUdu2CesvSSPmgtsOx+n2bcDpIzLCVy7RV551F67AQZj8mun6q7lF1scNi+MCFwfL9/L/w6KQrnwa9jPTcIA0b/2CQirL26yHPZuTc6joV8K/rbs5mQaurEWKDP2pN4UkPU5oGmWp3wQPn+Wd9rIydcb1tvHZfAORcFTBrLM2dCvOSSJUEwcne0irj383cLbD5E1L4VY5CVQ4t7nF7g/Lh5uvQNi7GgC+A+UDG3SVwyXXN+L5RIpXZOCzPDcKh1iR6lXkpV7AkfVber5dpYoPep/TjCyyt2jTWufgcimgkaUOKI8gZSUNyZPVzDM4J+/YiCQhnSKRGavXzxGrRvJjYUdNsVDja0MHr0j/k2AfT3G08nEdv64ecYIOqtHerozI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39840400004)(366004)(136003)(396003)(346002)(451199021)(478600001)(36756003)(86362001)(38100700002)(2616005)(6486002)(2906002)(316002)(6506007)(44832011)(6512007)(26005)(186003)(66476007)(66556008)(8936002)(6666004)(6916009)(41300700001)(5660300002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iPIeO+nJbiuj4mqM6HADFn3D94GstXvw58lxYrngUOZ79wdHedqg2np5mBzp?=
 =?us-ascii?Q?bA2IgfUWWCjbAAhiRDDtzi5vAeIj1RGc5VUqYmINBaPJ3ZmhGZrARaheAbM8?=
 =?us-ascii?Q?+XqMpMqpdPg/ra/y6UUNm9janFhWWy2AO2eiT6emOLIwgTyOW+QvyTo9BSzV?=
 =?us-ascii?Q?jCLn0nVkSmbq5ah4bg8xSxa4nMSfl7eAc1zvEq0h/It8rPZr2RvDC8IpmqNT?=
 =?us-ascii?Q?PvTxr6jN7DrKhMsWK/clo1a0MUn+a6wTDGOoyj3QMKBH87knNF2PqCtik1pg?=
 =?us-ascii?Q?pgtAOK4IFF1ZkOwfrv32CZXrtMpAVewfm8n+GpAn23YWWQfka7jWU+Od2eyb?=
 =?us-ascii?Q?N7LBWEq3JEcPdUhA8msnLaYc2PhhLEJeY60IgyZxsx0BxOO9pM0ByYvwcAnM?=
 =?us-ascii?Q?0mT8fAf0eXYEiWxTyDT1/phvH1bTrFejLmTUmeO7k/6LPP/3O2hxLW/G3bL5?=
 =?us-ascii?Q?fc7KYTSVJKH4uVXggelnWA0QhxgIDgQyumPjFD0YLLSHlGYebxH0pAZk2m5h?=
 =?us-ascii?Q?SRE9aAOxBJBqg/G0ADZVTbCat797WcWhMV5XMG9zT4Dg1IMawIOmTQ8hY2uQ?=
 =?us-ascii?Q?CXgExBUP1Rm+Raku4HU2JDxHXBvMyGy3oRtS2sYQPtYITS5tieZOV13iSdai?=
 =?us-ascii?Q?GqpG3s+vHeShRiJfhsGLGmb+yByPWP8MOeHkUqmlY6yGqy7sS+KLDMeI0Ca9?=
 =?us-ascii?Q?uGHnkkJbmKjTIbDfhtvZQFJFT1rAZTTMsj6DpgH4JiqKYABFvET74vHbV6+N?=
 =?us-ascii?Q?XWuS3VMGwXnCjMxA+pNZNLMJkLX3sfiWmbiMvK4toxmYiGVQGSNFk3sVRdvX?=
 =?us-ascii?Q?bktDl1W78kG3uo/yIxsSeurEgvZoNEzjCwMJzgj7f22T22e8DNnfE97oLPuR?=
 =?us-ascii?Q?Evb0FKxNQuc2+hGqEeUdwlGLueolgo7i8peDxr21S4s8YyEGWvVYWCBnDWFY?=
 =?us-ascii?Q?Giwr0rCPv8KG12PzWRp+nkfmblrc+3snFYEH2UMIY6/HLgAyriTDSkHF98n4?=
 =?us-ascii?Q?i9cjcNJ11fMnVRH/PoBDwEF0mKT1y+Tl6oSK66HepPWt6SWrUqbtlxcYj4KY?=
 =?us-ascii?Q?ZnxAFha+HOoSYR20x3KBMWdNmVLcyCwrVSM6v8vMDZWNpW6CWllSOZgbbXy3?=
 =?us-ascii?Q?CoPEqw9L51I8j1uQajBmr0YN/s+WiUG/N8djs55fAbdBCf22rU1VR2vPOxs5?=
 =?us-ascii?Q?csJI+HjaE0SbgPRpNoBhL84HOpvIKs4jmcXAkRV2m0BqTw4i0wJ4mvQWX8vX?=
 =?us-ascii?Q?J+2qiu4ZXeEcOPnctQrVj8mop3E7f6fpvrnoVbit3GTkuwo1YC2K8ZadplJe?=
 =?us-ascii?Q?lcj5ey3nx4SkKtSjwdRccdcOVdmJRSigeDRQuJ28sBBpn+k19SLmcLeW7cFO?=
 =?us-ascii?Q?gbCmzJuApZ9ef0Z2b81/9U5gjWTOmBRwDFRzfagwhWevigY9BPrK+sZdnAS2?=
 =?us-ascii?Q?hDVpSQNrTNAgDhRT0jVuvfp9AEd07FSgi4EnllnWiBjYNFmNieidzET3X4jE?=
 =?us-ascii?Q?Mzd6nYad7QxFfsGuhg8l0DqnUfDCEwdGJadX7YOoSsUY/D2Xk2e2uJkoZCx3?=
 =?us-ascii?Q?Tl6Qidi0uT5DInQtC0zq4I/18nmADLI5WdOAaJvT+nfJ9fXoPGpD8Avq+klg?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0f68b9-034e-4df2-ec37-08db3aa28a4e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 15:36:38.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEa70hyIq7TlKlhdB3idHOUM4p4nVv5PCrH3VYKdA0QHZPa4AR0KR6GxhcWiNbKZo6rJmQdJBU7BJSdaq/MdLZ00m/vjicWChjC7F3eErbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4640
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 11, 2023 at 02:37:50PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> [snip]
> 
> > 2. During the migration process, the memory needs to be forced not to be
> >    migrated to another node by other means (tiering software, swap,
> >    etc).  The obvious way of doing this would be to migrate and
> >    temporarily pin the page... but going back to problem #1 we see that
> >    ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
> >    troublesome.
> 
> Can we use memory policy (cpusets, mbind(), set_mempolicy(), etc.) to
> avoid move pages out of CXL.mem node?  Now, there are gaps in tiering,
> but I think it is fixable.
> 
> Best Regards,
> Huang, Ying
> 
> [snip]

That feels like a hack/bodge rather than a proper solution to me.

Maybe this is an affirmative argument for the creation of an EXMEM
zone.  Specifically to allow page pinning, but with far more stringent
controls - i.e. the zone is excluded from use via general allocations.

The point of ZONE_MOVABLE is to allow general allocation of userland
data into hotpluggable memory regions.

This memory region is not for general use, and wants to allow pinning
and be hotpluggable under very controlled circumstances.  That seems
like a reasonable argument for the creation of EXMEM.

~Gregory
