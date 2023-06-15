Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A462AEB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 22:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjFOWoP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 18:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjFOWoN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 18:44:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4C26A9
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 15:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMrzEUUt0gpWaLeBbohnyNLYW/csbRloCou9lL/wyv9qj25vfZuBIhiW1YnwXt+bTsY8dlPPM+ztW85qKb6WNeYOygo1TMp4v363Gb8QMvAnZHN3/lOF7adfrWb3QW4QjiZ6WVSX8/XIUBq+M982LcPhVGyfipM34TWnUd2Fr6ZYoiTBYrniXXfH+K2Eqc3KTOQHqypVRihPivQEFpso8Qh8/m9Trrn1fltKaGrbs224xuqzpI+3B7uaqb6GEE4slgYajmsliijzPZKlvZiga4Ac2TPswaMTk9LsfYBwFy5qcV8b8CvkmQJfUCv86hOD9piPDv79u4QWWt72DAWbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKtBkkH7LkvjaJGldXur30I+ruR2wcvTTrJ4SXBO720=;
 b=Y0J0hzy/bIlrFoNwj81FFXGuIre+sYigglrrdGd0EzF/VKN3UqfhpnNEcCaqSY5NYQcDVqMhM+DSim1/npZGe8q6WCzG//fKN7v0ze9jPNzFKQzqr74VZGKr9tl+IlBeLhx3S2OxmaTkZ+7ViWUi7AGD08sFh39P6pD3qtpCRJkUF9G96DdNGGmcvKVyUF+oavWhyGUFNAuJFJbIUC0c1KB1O6tkPAv5fI8mWjknxhs+6nJ9wrzKMSzG54Oc+C/HQlruesYknhmciP6n7fEfe6JUM5B11nwdgE4I9oiXHA2za8sKMk3jlEhx6/fH6LOJT6zB78jehojMWW1ftLde1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKtBkkH7LkvjaJGldXur30I+ruR2wcvTTrJ4SXBO720=;
 b=M6NdtxtQ+7T3lJO8hJMtdjzCuhagOqRFVVJGg8G6SVgTdnil6DCb9BnZOcwPTMtji9rJjjgz3AJmX5swI1f8qN91ScfUpfZrFSgijLe86HXNkP4hY0PjYF2jB7OoZy6wmK5Bhj4+74atk3p41PuviaO58nn1tYEbmpoVSCE3WaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BL3PR17MB6116.namprd17.prod.outlook.com (2603:10b6:208:3bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 22:44:07 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 22:44:07 +0000
Date:   Thu, 15 Jun 2023 18:43:59 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [BUG] Root port fails to match with port driver on non-RCH
 topology
Message-ID: <ZIuUL/hKp+RdhTna@memverge.com>
References: <ZIs5Ra+9SGGbUZoZ@memverge.com>
 <ZItcdaq3j8kW+/Sy@memverge.com>
 <ZItdoWTyOS5YSPzz@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZItdoWTyOS5YSPzz@memverge.com>
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BL3PR17MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1a58db-7083-42cf-c8b7-08db6df2070f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyd4EPcfUiugcMfBSCR8UJyRu0eVozvtTt4rZS1X68VcRSXuiJ1pnc79+ujf5EpV5I1QlSGJS/AXUrywKRD7scw3m80YIHR/RqdtaJZ1UXV+FKVziUe9pz/Pfc9oeU+OHdD88BHjMeQyfQcLD2hF9lmRsjEbQDb4UZkgbO3TkGzioDFyeJLkii1+TUfnlWuLIGKRZ3z1xbNB1v/ssDsDnHwP+sAAox1aTqQuJibRCdgojXWUqAEQZyT4svrv5D/FgZk6gaYI4O9+HaTmEdqmVtIXcLQyf6wJXk5WdWnTogcAKo/DG5FLx6IR+V3owNAh5lWHLxYuzFyQ3raCfahELPTZ6yXXjQH7IE9DD1xJ8+RlQMTqZVv+ByeELHJmUgpUsw8ESRjyRuE/UXSI6aaLpmxyRp5+5rK4ISM+i2uLfUUewOIYigt75oPXxH0MuyxNfFYbWhpdBQ3UQfW0R9U8kMXJhjSUWe4PisWvk/O5pLdtc31/qHSqLRYgPn+vb2hbaZm+uyS8H2ieCXgMEaaWVjPH8dx0NhilJE0zRYKsW2VcdH8rW8v0qAFcNDx4j7XE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39840400004)(366004)(396003)(376002)(451199021)(6486002)(6666004)(86362001)(36756003)(83380400001)(2616005)(38100700002)(6512007)(6506007)(26005)(186003)(6916009)(2906002)(54906003)(66556008)(316002)(66476007)(44832011)(4326008)(41300700001)(5660300002)(478600001)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ix2hIVOi1cFJAcBrqEuzZ6x0rQCl0Ovd4cp7ruw2ORqohVJSHqSs42Sd0viH?=
 =?us-ascii?Q?CgPZZOfrJzv9Mfyy2DCzF+P+QjKPk8g5J1oPNuFkgeMrsYjApPqO2cLlEvW4?=
 =?us-ascii?Q?mORqSbdBzt52jc0HcxjL/YU7CiP3sWCEe93B6ugMw1hCQoh9ybZqbvSg/5BX?=
 =?us-ascii?Q?KM7Nv0gleTEBKTKsdleFTDdsO4UeJ2DlS0xJPIeFc8i8ItPBf4B3KXro6g7N?=
 =?us-ascii?Q?/VCURuye3YGfLmtgGyX6/zHTdS3vt4VdepzCExTpdsWPjiKTP8BHDouHjWAm?=
 =?us-ascii?Q?zXdbGi1PPVt67V100HMZ5wStOS6k9z5sFoCqmu1cxA/JmW4R3/Vaa0zygayt?=
 =?us-ascii?Q?o1CJ924tCaxZPBLVqxcqstZdDjAoIBfso+fQzrRhYQYFtBUYrXmnN2WC2AEr?=
 =?us-ascii?Q?eYFy7zumaYyBwOd24XhUohYEtrdrs2vUTZy8Hv1GMBN8dR+/IhE0viKtWu4S?=
 =?us-ascii?Q?JEfgPvLC+b5H/e+zr7yLqFrcBJ1/t1mmVR0sSJGOVVnnZb8MDD4hCPrjyTWJ?=
 =?us-ascii?Q?/oRAPcEjXlcozVvJrouswqemV/RDd81MODKD8L9bAhIcLzvK9q4UMnEUSnyX?=
 =?us-ascii?Q?aaVIVn3JS4PMHLodEdLTN5oWlskR1pxK3hMgmx64FXrwMOi7Q6Sv2y8YvCMd?=
 =?us-ascii?Q?X9fEBGcg0PTjCtO5frMwpM1R0yWhW8/qJtTAy+DvY32omyAi8U4zraYKLuRN?=
 =?us-ascii?Q?9tjfjeZRRbm4QPq4vYj7YrBeny5kXVARo265BaEaPuBY4GXnIZijVeqTwq70?=
 =?us-ascii?Q?VsPg1i4oiBaexyMPr0/rIVQTR5XVQQxyyojRKenN49yAmUCMklSK/JvETvDH?=
 =?us-ascii?Q?aL/Dps7qcZW3PH0jyWHL5qySx3LbAa1kWgToppkbftJWTvD5AsymkXa04Mfr?=
 =?us-ascii?Q?VuB8hsgvEV4q6z51kbjd7WDI8QI59/pWdGMVdcMdrFu82Lr2CF83HJq3EcPB?=
 =?us-ascii?Q?4WMCBRIigGu5gLX84CYKLD7KTom+GE4kk8uejNtAzv0xFUbtnQ9UuGJpzS9i?=
 =?us-ascii?Q?VbtNBBf6cjX6626QzS4zXt9vvJMjQfCIYlp9J7eydjIgk2cfbJp4NBPJEieH?=
 =?us-ascii?Q?ooHpnj4/cmy9bC7doZ/oRYm9gC7aF8mZn3Fr5O6qF0s2g+nWrZbeXGHw4sgg?=
 =?us-ascii?Q?uv9TwwCMasWgapnZY4mXTGxgsEnrgbYkWtT7npXVzxU5usft47ywop7YDXfz?=
 =?us-ascii?Q?/+s8Ja2mmfK4zoi2eIQUKf3g13UN9FZtzO1bNU3CedUhx737qj9/I75yMVUj?=
 =?us-ascii?Q?juB4MqiTWrCQewDPSQBDo0UxUOm8m3Zj1gtzngToD390pV4y9wDaFuNkvWdY?=
 =?us-ascii?Q?Gav3GfYUjnEqDEx29+GxblZb8DKrOLU5tK1vyW6oW6qmPbbc61A+1qzGIn1W?=
 =?us-ascii?Q?IhEKM53FbAKFlKgMTIziRpbujVmybTFMXE08GZZZcrDL9MYJVEr0PIDMi9mO?=
 =?us-ascii?Q?wIm9ogTHEPzw18CWq6BzjlA/xGksD37Og4/bvVkogaxA2WsRhOnStsi2oBJU?=
 =?us-ascii?Q?OtePp1MugAZ7eDqHiiYzpsjUTXSpZhbA2Q/MJCUdDHh+rya6JrCEwXI+XF5B?=
 =?us-ascii?Q?J6tWLmErzVO2dWnTr1nQNULsLnE6YuHggVH6hsD4mlYiULgObT9nI0kE9J17?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1a58db-7083-42cf-c8b7-08db6df2070f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:44:07.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXLjK6strMJM5Hl0X3VZVFpVMLeK7fB6d2Psi9ZouR0uVy3F74+jXejl6cKKBKFdoPrqXOAulNq+Uvj9XPU5tbbD2LTB5FAh5Zi2LCDYuQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR17MB6116
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 15, 2023 at 02:51:13PM -0400, Gregory Price wrote:
> On Thu, Jun 15, 2023 at 02:46:13PM -0400, Gregory Price wrote:
> > On Thu, Jun 15, 2023 at 12:16:05PM -0400, Gregory Price wrote:
> > follow up with more context, there is a subsequent error on
> > cxl_port_probe which causes dev->driver to remain NULL.
> > 
> > 
> > [   15.561313] cxl_mem mem0: CXL port topology root0 not enabled
> > [   15.561315] cxl_mem mem0: call_driver_probe failed
> 
> wrong prints here, this should have read:
> 
> [   15.549316] cxl root0: driver set to cxl_port
> [   15.549732] cxl_port root0: call_driver_probe failed
> 
> I confirmed that call_driver_probe sinks down to a call to
> cxl_port_probe and that is failing on cxl_port_probe(root0).
> 
> Rest of the commentary below is accurate.
> 


so cxl_switch_port_probe fails on this stack:

- cxl_switch_port_probe
  - devm_cxl_port_enumerate_dports
    - cxl_port_to_pci_bus

int devm_cxl_port_enumerate_dports(struct cxl_port *port)
{
        struct pci_bus *bus = cxl_port_to_pci_bus(port);
        struct cxl_walk_context ctx;
        int type;

        if (!bus)
                return -ENXIO;
...
}

struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port)
{
    /* There is no pci_bus associated with a CXL platform-root port */
    if (is_cxl_root(port))
        return NULL;
...
}


I presume then that for the root port, we should just return 0 to note
success?  The rest of the devices should register themselves correctly
with the root as they're iterated over - i think?

What I can't figure out is why this doesn't happen on QEMU, which also
presents a similar topology.

Still not sure what is correct vs incorrect here, will need to dig
around in the spec and system settings unless someone has an idea.

~Gregory
