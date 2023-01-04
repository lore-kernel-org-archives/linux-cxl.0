Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A106C4708E
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Jan 2023 09:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjADJm4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Jan 2023 04:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239152AbjADJgt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Jan 2023 04:36:49 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39C71A821
        for <linux-cxl@vger.kernel.org>; Wed,  4 Jan 2023 01:36:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVdtI/KDuCj1LOQZgqEBBKobaagfS6MdpMEtRjI8VXmlJl6X4sJlsB31kyc/IgfGluBcws01kE2aQT/IlqPRtZeO+aMUTjV3Dw8wqfuW1DWJ8ZRL4pRj9vaIi+J58Dmjg9g+wKAipc4LyzPSDOeWmGxrXwDRRn5HISZ8gcIv0iZ9CILBo5q1qb89GgdjVYcdDSU+xPlyhybeivIwTEAVtjbvxwGgOt7P3thTIv9dBOpEv7V22VsQheMRTb6hXDuJBx3u6Dz9mt3EbAgU8rp5AyaJPQwTwWDMmMoREfIvtwQ2onv827pBCjrq+XmSKv/t6J26sebP5cBxZlB4T3x0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr8Ix0JBOcgv9NrJtbnk7GBNnf4ImbqiM6C1seH8Xxo=;
 b=Ftptq/UBrbapFZtHrw9wfm87OrJOolQzxFMubui18gkuYUhGstmxvVP/G0CAXOxUwLbv9KRbzcl8GjTDV2MtJ6uZy2vUWWcY2m1aZmxZKOZSrvlv2OX2g2ILXlYxpOJ75+zj2WAWSfT9CtJ99KQvy7lS+Cfw2I09XWju6zWPgXyT12HX/C715vsQCNNi4KO1EZYj40q8d7gFplkzshPLOz5MZ5wBGUri+CkJBmi82E2HxMkN+7y/YUxhmHMyCoK2s4gULnT+quO7LIpAZwqWCKmNAL69BpJ6Zy33M6thUPpzB7PwxXo2PMJHf7vl06fHZXc0t2ZOvfTB/mQ0RQ+uxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr8Ix0JBOcgv9NrJtbnk7GBNnf4ImbqiM6C1seH8Xxo=;
 b=aPknwb81TH9fl2XNmDjC/3wgK54qzTlfVirT3s7gtD5njeynphJRwUtP4VMG+EiEl+7U1w1t2gyRlbVCYpzcTnFRITK+lsKCuZhS2b+DfW6nKbhEtz5gQgn0PTUrXAYRzMHnOrVIiy2ii9lC9NMNvOX+WW8xBaGaZCygoc8TraE=
Received: from DM6PR13CA0034.namprd13.prod.outlook.com (2603:10b6:5:bc::47) by
 DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 09:36:34 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::84) by DM6PR13CA0034.outlook.office365.com
 (2603:10b6:5:bc::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 09:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.14 via Frontend Transport; Wed, 4 Jan 2023 09:36:33 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 03:36:32 -0600
Date:   Wed, 4 Jan 2023 10:36:13 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Robert Richter <rric@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mem: Quiet port walking warning
Message-ID: <Y7VIjfnd957nCncQ@rric.localdomain>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
 <167124081278.1626103.4792472728150764118.stgit@dwillia2-xfh.jf.intel.com>
 <Y7QIP33kUAEPp6sb@rric.localdomain>
 <63b49906246a_5174129457@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63b49906246a_5174129457@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 900af46d-a39d-4e57-49d5-08daee372b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1hLhEdW4kQxu1G+/b+4zrRDVmM7ef4VjJYGaDxAB+GB1yXE0H2FKqSUjtWYEKGXeyg40hye2VL9ebtysGA6jqPMnWHuxtVXt8oTen1CIPSgh45pALZbfjmSY+Bo/VrDY+2FzdoadrAS+PJ0G7dwCGkoFFNFZA8DhpN1Mr8J8A0LhPKIoPyg2rABK5sSkt7hYZ59Wn4+XN2OVRrfDnfq+hY4pAJiDd6eztNz/EnVRM2XDQpGOQke0OToayz3tkrkYjLUJD/f6L2neSiWb1GSp1uifPfVFMs0umJzOAuQ3R777+jwr/Rs/cIDSvJP1qdLT0X0gasnATViNt60M8NeMR2SIprLieCHzzrlxAWi7F/kYKDhDSNw3YfD8FpB8khdbjc0eb4230eE4was5ZjbVc3CsQGUgY1SQSwEv5aw7QKR7tkIueOMlO086H6EDy/Hm5T6/u8ZcBiYp1rsl/kPLGdn3v8D8H3HoPFl6faJTTNy1beJIVOnAk5EIuHX8hb912Xipj8cKf5rbIcVUfE/TDQZtA1lmmx/oqzB/zPS3QrBcuCgxJ+Rx1HIbrB1BKBmN64s3ZzeSrk9MZGW3u3HB68XHk1Bn0i1VIlVKMuGytGwczd0e7qg9/BigHy5TOUHclmghqVxKoxhqY7ml/XQaRYzoOF0duyCJ/DiP56OsR8Jrn7IPzEog3c0LiRoB3YKYFONzLc6o7Woxx+kJvMUtwEeyAdht+kdVSCYZVttYPIfIF2PeWC0vODB17ykEjE1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(47076005)(336012)(426003)(9686003)(186003)(26005)(81166007)(16526019)(40460700003)(356005)(82740400003)(40480700001)(36860700001)(55016003)(82310400005)(54906003)(6916009)(2906002)(316002)(70206006)(70586007)(8936002)(5660300002)(8676002)(4326008)(53546011)(6666004)(41300700001)(7696005)(478600001)(3714002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 09:36:33.8483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 900af46d-a39d-4e57-49d5-08daee372b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 03.01.23 13:07:18, Dan Williams wrote:
> Robert Richter wrote:
> > On 16.12.22 17:33:32, Dan Williams wrote:

> > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > index 810e60cc331c..6296d2bc909a 100644
> > > --- a/drivers/cxl/core/port.c
> > > +++ b/drivers/cxl/core/port.c
> > > @@ -1400,8 +1400,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> > >  
> > >           uport_dev = dport_dev->parent;
> > >           if (!uport_dev) {
> > > -                 dev_warn(dev, "at %s no parent for dport: %s\n",
> > > -                          dev_name(iter), dev_name(dport_dev));
> > > +                 dev_dbg(dev, "at %s no parent for dport: %s\n",
> > > +                         dev_name(iter), dev_name(dport_dev));
> > >                   return -ENXIO;
> > 
> > Maybe we should also change the return code to the common -EAGAIN for
> > this case here too? It looks like it is just passed to
> > cxl_mem_probe(), so there are probably no side effects of this change.
> > The probe is triggered then again by the base driver.
> 
> Good point, might as well explicitly return EPROBE_DEFER rather than let
> the driver core turn EAGAIN into EPROBE_DEFER. Tests seem to pass with
> that change as well.

Yes, EPROBE_DEFER is the one used in the Deferred Probe
infrastructure.

Thanks,

-Robert
