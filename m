Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA1FC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Jun 2022 16:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiF2QCz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Jun 2022 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiF2QCe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Jun 2022 12:02:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2135.outbound.protection.outlook.com [40.107.223.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C53DA41
        for <linux-cxl@vger.kernel.org>; Wed, 29 Jun 2022 09:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bs25bLp8aSmsjQi1F+y4rrqC7edx5VdRN+USW8PN1PpsGaaFY0cbNNRhNlhZYh8R0lWkJA86mz+b7LYWGT1EmhvPcaNhvbh/GV3dJ1fOSVEea3jRp4q9h9S/93YKux/g4UgEUpeIhP5CNEgdMATeShKZC4DTvWsok5dpGYVkP8fGqN8UsYzvU03ogqhcv4Ex9bx9h5x5AoVac9n/yhu9UwElYHxw/8ug6EMbUrjdDGO5DwFqGvlFyZIPEBbOnnAPAbAdPJKl6H1+sdPlBPN/xs9kyEbrx6rCsV0RJIVf5vdLDjoSWUoDX7iR3WRh/iltHU6Dv5jw0taTvi+kEEN6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytb+8HFakeNDWBBEbWXVx2c+TlaqQt9GTAkhiWvO3x0=;
 b=CIDnUHNfnTANbmxX3UZMoXwY/BBUMML+/1jTowi2oko4KGUYVpJAIxeRxRZw1FscDnuwzNlI8RWf2KoIEoiBhPoescsrH+JSWZcFfRQys0XEDSZYuVeDnz8IdER60txj9q6NKrXRB7GhzhKDDaRlldgk2eUd0VO6zhoHUYkua8TrEf91zhlSGbybxpkYtal95TJwhQO1fVe+989tNO9Ea6l94bAxXk05tQ9I3jbNxn4EMiPD53DRq5jjoecbz6KAvgJbKblmzaFdoKngCb8yh7x+r/MjT2pNhXy/3TzQyZZRO10zsNKHP8LKcaOxQ9f9BfUBSlYZ7UDrOf1F/d03YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elastics.cloud; dmarc=pass action=none
 header.from=elastics.cloud; dkim=pass header.d=elastics.cloud; arc=none
Received: from DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) by
 MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 16:02:00 +0000
Received: from DS7PR12MB6007.namprd12.prod.outlook.com
 ([fe80::e9eb:55ac:62f3:f096]) by DS7PR12MB6007.namprd12.prod.outlook.com
 ([fe80::e9eb:55ac:62f3:f096%9]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:02:00 +0000
From:   Mani Subramaniyan <mani.subramaniyan@elastics.cloud>
To:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: DVSEC FLEX BUS CAP bit 3: MEM_HWINIT_MODE
Thread-Topic: DVSEC FLEX BUS CAP bit 3: MEM_HWINIT_MODE
Thread-Index: AdiJ62AvTeOmYwdPQKq/w7nxUnfXngAc3vSAACgB2qAAClBaAAAqL7dQ
Date:   Wed, 29 Jun 2022 16:02:00 +0000
Message-ID: <DS7PR12MB60077FC4536970D4DFD2FEF79CBB9@DS7PR12MB6007.namprd12.prod.outlook.com>
References: <DS7PR12MB60074C18A01B242F165F68009CB99@DS7PR12MB6007.namprd12.prod.outlook.com>
 <62ba0987bc7cf_1134f9294f0@dwillia2-xfh.notmuch>
 <DS7PR12MB60077E9A94B20ADAEE883F109CB89@DS7PR12MB6007.namprd12.prod.outlook.com>
 <62bb5b3ae75b7_1ab197294af@dwillia2-xfh.notmuch>
In-Reply-To: <62bb5b3ae75b7_1ab197294af@dwillia2-xfh.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elastics.cloud;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6950076-6867-446f-e0f3-08da59e8b370
x-ms-traffictypediagnostic: MN2PR12MB4360:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fL9dVEWp9SPyI79zNIYPHYhx6DgplZ6LBuGVe6/Z2iF2m/CNULLypnvW3i7csYRp8857EayQdXG/izpkgrmP9MtoJG3txJfwIYC0wTZDuaCI189zwavNn5TuZNEym4x+oCyZUqe5+Orqta/Bo8rcjnmSWRX8xCF3tWOo3KX6id6WpT8AQCKPCT03NS3YwGKwRveRl5XeZJT8AdmkH32Z9pi5bZwufCJVtXgH9rhsfaXPHyX4+bOrsOnuKyeDCA+t8NkfXF5I+qlpqV8chXQodtgtaDozenUHE8zplagz7cLHjwXbcTN0iEBhNkwMNHd74EFNQwTlqn57EWnAb3QSOp9XLFyjhhdO8m3kyyJR2nJh2j9LCkUSzHx+iAhjJP0JL8mkFB4hr4RGABigU+ZmmjaWF1/+lFWZil/d3fuDbvr9mnKqNM2ZCA69CRrDktsFbizJrMyKSEBmjue3iBSHcLR17Ep/pVfR5QwUVchvz5xZr03vJTc7Nj2SdtNv2wtQMD9LujsiKI1P/tOxJIQP4opipfLBpt7W5hbnGVJTPwm/Oi6MxT02rVkHYvIoGhOkq+yt8jK1qZBuFsBVnVTlmq/LlCPUtkyoTYD/UjmZCDXPCvNEWPdt4BbaZaqpHCoQVXfnflxhQ5XG5D7tsRrZMsGrvFk6jQI9kMFpXgneM2dyohvVLAu6ivVvJUAXq75gHvzgifwZTG5XGJmvAko3HCkCqUSUlQQL8yGGm6fAL26JQb/BKvwCTVdSvlFgTBJmq9B5oxvHY65tmvbxMR48g7c2T9SN1S0Qp2WqmdzwHkhYvGGQRtJlu08nZQfuhYQSVIRRL0NOKfrJfcgq3f2bQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39830400003)(366004)(122000001)(86362001)(53546011)(316002)(33656002)(2906002)(44832011)(186003)(83380400001)(66556008)(76116006)(7696005)(55016003)(66946007)(64756008)(110136005)(8936002)(5660300002)(8676002)(71200400001)(6506007)(66476007)(9686003)(66446008)(38070700005)(38100700002)(52536014)(478600001)(41300700001)(71440200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?81CG98YZBTywGu0iL7GlkqwnE3OsY2T9GoMF6rkJ9gbxNz9us1AcQKIiR6Jy?=
 =?us-ascii?Q?qMyNxBFwD+SdhokqFkJZey9HUKl/jnfUx7D/N24LVPE15j7W59IjvX8JsxoD?=
 =?us-ascii?Q?SNLJXUNEEaTOtOKeJPQVCIiwdPdRHDs1OGt2s/nYVNju19YxLHM74JkXaCO5?=
 =?us-ascii?Q?PvdFCxgo8tzo2qGuwmtKAZxh/sjHGpj3uv84hLSqf8YMdseYb4eWXaBv0N4G?=
 =?us-ascii?Q?xAFHHqjizqYO7Kmo55SdujOE1QvDYMSkFr+2P61BK5ZIptY4DwrLMW8fg3Ex?=
 =?us-ascii?Q?W3VjmEUDOK2Ju1iOLhKp8UvTajwgYquRAv1HiyuMwzIs+YTEGXKTmmBDFugo?=
 =?us-ascii?Q?nJZ9LKspdbNx2+TXOJFBQXmtzEtfspF88rGYHZg2U2+RzOQ+NCqimmHI/lW0?=
 =?us-ascii?Q?eHSJgIo5ntQkX4zep3tSLdxVi1b/1fSMf0jJU5GWKBtbOZ037Y8lixsneVlk?=
 =?us-ascii?Q?K8rBma1xfkyqrBUHWvGiLzvWWmz8FSrdy6ITz2gb69t2FOha4cRWUyK7q0sh?=
 =?us-ascii?Q?jBiayqrWTZ0bnJWBdqnoxI9jkxjaPN3ueTEORWTWpZ4narf6KYkc7Cqj+LGW?=
 =?us-ascii?Q?qT3Gj5e9qkClorXzfZr4cvNRlDbzjjWt/Vavp2GLOlaQMNpxr+4UqR0iRWEq?=
 =?us-ascii?Q?Zt8qo19BqmAHswUYjgnLun1BXsKHmSA9NCxtDnAeDRsp6TyRR+8K49sFttno?=
 =?us-ascii?Q?sYoU+haHIdp2CFigWobVxk1RQKvkupofP2x/DYh+pKjT2Hh4ojFSD1UQdrCx?=
 =?us-ascii?Q?oHF6LG4nW/Kcf4MkJU0N7GKRf3b313yr1grwlKlR+J0/O8WRVcY9dZJ9+ElE?=
 =?us-ascii?Q?YWNszwTHkt++o6dfJwV3tkmIeoNxuW3hF8jI1kRVvKSm63xHlAeXZoM/mYO5?=
 =?us-ascii?Q?0Zmwa02jcjTSiAlUHnajI1XV6pN3tbGoKBPws55wnScFhqRz2qRDRNTYznG3?=
 =?us-ascii?Q?qQtxwS3PqUqrRZk54PPzd1Yh/G7aXEEOGzzl4oM1Blqk9wewqBBQCOzX2U2d?=
 =?us-ascii?Q?qM8Be6rEnIFFuPuOtHUuizouyBrsOMkVYReAPq9qlfGEjEvlYl5rVRfR57NF?=
 =?us-ascii?Q?UiMO6tru4W+8gsqywrbrs1edzkVJ7LJ4f2A67Fy8xNOVTCwCOon4XLjh2s26?=
 =?us-ascii?Q?C6485IpwyT1aW18un3STZJZZMelH9Q6OxJo358fNP2YckHvsSw/K0LqFx9IV?=
 =?us-ascii?Q?e8HtR6Q3x5++GbG7a288bzQtLOwhAmajLCOd3cZo9ovANZG2f3a9Shox3gAo?=
 =?us-ascii?Q?cBHlI6cXPzMNm19IGO6tc9CHaaF//2/oa8uHabC46ZZoKyVkwTHicJvbaeRX?=
 =?us-ascii?Q?K6ugl91o6m7i3ps8uPgym5ugtyt0dqypeX+VLNG+7BMZ1WaT45pgXbKyCPhb?=
 =?us-ascii?Q?Vwo4fWNbajYtzzaVBu7iA7oj16DpU5qVucRlnMczcnkeOv0inOPtal4NQNhT?=
 =?us-ascii?Q?I7IDDrSXfcPP5zK+1oldDKkwvFdFAW20O15L+p+NgHbDMisI79rqlUIKvm1T?=
 =?us-ascii?Q?Nz1mx/hJMcvdY0/hWGshHnSt3lQan6J4PLrcNUtNztQvcU0Xgn9DnKfiZjk9?=
 =?us-ascii?Q?tOizD/JIh5ahxV0z+RkcwXJHH+h8Q4Yq5+jCKUcVCQMcNSsq0WuxRgIwcB4R?=
 =?us-ascii?Q?lbyS8jXDHSXvNmAu7U4KvNvFxpiuGbgqK07YfCJRdwhjNhHANoCJwSx/PVPG?=
 =?us-ascii?Q?ySMpPWTVV6QaQtWLs3gzM+wJmxQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: elastics.cloud
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6950076-6867-446f-e0f3-08da59e8b370
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 16:02:00.3838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 28558b47-528a-463d-9ef1-81068bcc77f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMVeazWo7e3yn0IyAKffptQsohm4kMJDCP4uSfQxaF+ZiPy1wO84JzgZk8gLVMs27mD0XzfcwQrEttPHemA9+RpeWPdIKgC+sVVdkCrYFAtqPPv9BWKMuNxoapEq6O5k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Yes, my mistake. Only vendor drivers have to load and initialize when mem_hwinit_mode is 0.

That said:
1. The CXL code in linux has to look and take the right action for mem_hwinit_mode==0 case. It doesn't check it right now. When I can I will get around to proposing a patch for it here.
2.  The CXL spec has to add some verbiage to clear this point. I will follow up on the consortium.

Thanks
ManiS

-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com> 
Sent: Tuesday, June 28, 2022 12:49 PM
To: Mani Subramaniyan <mani.subramaniyan@elastics.cloud>; Dan Williams <dan.j.williams@intel.com>; linux-cxl@vger.kernel.org
Subject: RE: DVSEC FLEX BUS CAP bit 3: MEM_HWINIT_MODE

Mani Subramaniyan wrote:
> Thanks Dan for your answers!
> As for MEM_HwInit_Mode, spec indicates that when it is set, hardware 
> has to set memory active in the range low address bits within 100msec 
> (it has to complete its internal initializations within that time).
> 
> This leads me to assume the following for a software initialization:
> 1. Both mem_hwinit_mode and mem_active are set to 0 by hardware.
> 2. OS loads a driver (either generic or vendor specific) that talks to 
> the hardware and does the hardware initialization. Hardware, after 
> completing the initialization, also changes the mem_active bit state 
> to 1.

If mem_hwinit_mode=0 then the device is using a custom memory initialization flow and the generic driver can not be used. This is because mem_hwinit_mode=0 implies a non-generic / non-standard initialization mechanism. So I think a device that sets
mem_hwinit_mode=0 must either not specify the common class code and use a vendor driver, or it needs to make sure that the platform firmware has initialized the device before the generic OS driver attaches.
