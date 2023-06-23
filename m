Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55791EB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jun 2023 21:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjFWVq4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jun 2023 17:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjFWVqz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 23 Jun 2023 17:46:55 -0400
Received: from us1mail02.teledyne.com (us1mail02.teledyne.com [140.165.202.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79DDEA
        for <linux-cxl@vger.kernel.org>; Fri, 23 Jun 2023 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=teledyne.com; i=@teledyne.com; q=dns/txt; s=TDY-2;
  t=1687556815; x=1719092815;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=hC+p87Zr4BOxQ2asiHn8CgzszNe9F+53gNZv8fzFEQE=;
  b=Q90Y+8Vk7oBqcjJua8jj2Bvs1U2yUGnj7e+5CXrVJKUP/ASqEDvFEmpD
   R6IBnqK+cseVrWxNMHpGZgq/Hq63OZM/kj2d1lR9j28LNH5T0jaHEsiTI
   41ifCmXyVsjIkT7JsR+vasCF4UEK/ofoWPLtXJX2/WXPdmsDpI8s/+/6c
   KU0gGF3jHT+eSC5rDyOg72FiTUhT8ATRDGPEmakHLVVKF/I7OxAVe2rpY
   M2AD3/4nFGSvyWVMqaNmLySDGr2u8p/sk2uHqmSxKmoOjGjgtWgo9WMU9
   9vaT3N6i7Z0/UUGUXJpqrGS+f9FreWv9o1JHLCloz1ja0LqqTBH3OpKNt
   g==;
IronPort-Data: A9a23:/EsUsqKwFxErQzwuFE+RkpQlxSXFcZb7ZxGr2PjKsXjdYENS0zQCz
 WRNWmHUbvuDZjH3L9F3aYq+oEMG7JCAx9RiHlZorCE8RH909fbIVI+TRqvSF3rKdJGbFBo/h
 yk9QoCYdpxsFieEzvuJGuK8xZWp/fjQHtIQMMadZmYrA1YMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMTdJ4RYtWo4pw/nrRC1H7a2aVAww7gRWicBj5Df2i3QTBZQDEqC9R1OQrl58R7PSq
 07rldlVz0uBl/sfIorNfoXTKyXmdoXv0T2m1hK6bUQAbi9q/UTe2o5jXBYVhNw+Zz+hx7idw
 /0U3XC8pJtA0gQhV43xXjEBexySM5Gq95fpLnWutJ2Pn3fFUHvp06Q/Fn0HHoAXr7Mf7WFmr
 ZT0KRgwVUnGudqT+53+b8Nc3p5lMMX6ep8Svnxs3DfUS/0hRPgvQY2TuYcehWltwJoSQLCFP
 qL1ahI2BPjESzpLN1QMAZQyhqGNj33ubiZYuU6Oprsmy3TeyAF9wb7gdtHSf7RmQO0MxBfG/
 DyWpT2R7hcyNd66lyCF3VOWu9DhomTJf51VM6S/36s/6LGU7ilJYPEMbnO/oP+kmgu1S9Z3N
 UMZ4GwtoLI0+UjtScPyNyBUu1bd4kZaAoQNVbdmtUfWk8I4/jqkO4TNdRYZAPROiSP8bWZCO
 oOh9z8xOQFSjQ==
IronPort-HdrOrdr: A9a23:j5wAoq/lvaHbsp0t/3Juk+FVdb1zdoMgy1knxilNoERuA6ilfr
 OV7ZMmPHjP+XQssRAb6JO90ca7MBHhHPJOjrX5Xo3SGTUO2lHYSb2KhLGKq1aLdkHDH4VmtJ
 uIBpIOa+EYemIbsS+V2meF+p0bsb+6GeiT9J7jJ4sGd3AdV0mehT0JfTpy7CdNNX177NMCZe
 Ghz9sCqDy6dXsNaMOnQnEDQujYvtXO0InreBgcGnccmXqzZB6Tmc/H+iKjr2cjeiIKxa1n/X
 nOkgT/6Knmu/anygXE32uW65hNgtPuxtZKGcTJ06EuW0DRoxftYJ4kV6yJvTgzru3q4FE2kM
 PUqxNlO8ho8Xvecmy8vBOo0Qj91zQl7WPk1Daj8AneiN28QCh/B9tKhIpffBec4008vMtk2K
 YOxG6dv4o/N2K/oA3to9zTEx16nEu9pnQv1eQJiWZETIcYYLhN6YQC4UJcCv47bWvHwZFiFP
 MrANDX5f5Qf1/fZWvepHNzzNulWWl2FguaQ1IFptee31Ft7ThEJwJx/r1Top93nKhNB6WtyY
 //Q+tVfPAndL5cUUoLbN1xC/deKgf2MFzx2aKpUCva/NJuAQONl3fa2sRI2AjxQu1z8HIbou
 W9bLtb3VRCO34Hvqe1reV2ziw=
X-Talos-CUID: 9a23:6d5hPWx7irs15y4etFv8BgU6Fc00dyzBnE3TAE+9GTc4UoGkalKfrfY=
X-Talos-MUID: 9a23:TO9UtAiuz8RIF6rnwWq74sMpNcVNvb6uJ2E3rKoohI62EjM3HC6apWHi
Received: from unknown (HELO US1-VPMSG-MBX02.tdy.teledyne.com) ([140.165.245.31])
  by us1mail02.tdy.teledyne.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2023 14:46:54 -0700
Received: from US1-VPMSG-MBX02.TDY.Teledyne.com (140.165.245.31) by
 US1-VPMSG-MBX02.TDY.Teledyne.com (140.165.245.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 16:46:51 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (140.165.200.224)
 by US1-VPMSG-MBX02.TDY.Teledyne.com (140.165.245.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 16:46:51 -0500
Received: from DS7PR14MB6811.namprd14.prod.outlook.com (2603:10b6:8:db::7) by
 BY5PR14MB3846.namprd14.prod.outlook.com (2603:10b6:a03:1dc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 21:46:50 +0000
Received: from DS7PR14MB6811.namprd14.prod.outlook.com
 ([fe80::6c34:17eb:337f:fed4]) by DS7PR14MB6811.namprd14.prod.outlook.com
 ([fe80::6c34:17eb:337f:fed4%3]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 21:46:49 +0000
From:   "Malyushytskyy, Oleksandr (US)" 
        <Oleksandr.Malyushytskyy@Teledyne.com>
To:     'linux-cxl' <linux-cxl@vger.kernel.org>
Subject: How to find the base address of CXL 1.1 Downstream Port RCRB for
 specific device
Thread-Topic: How to find the base address of CXL 1.1 Downstream Port RCRB for
 specific device
Thread-Index: AdmmHBeZwxbLEQR7SaaaC1ebmpj4fQ==
Date:   Fri, 23 Jun 2023 21:46:48 +0000
Message-ID: <DS7PR14MB681169E77C375801F9EF10859023A@DS7PR14MB6811.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: =?us-ascii?Q?eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpc?=
 =?us-ascii?Q?L1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ZMSVIiLCJpZCI6IjE3OWFhMGFmLWQ2?=
 =?us-ascii?Q?MWItNDUyOC1iMWRhLTM1OGNiYjNjMTYyNSIsInByb3BzIjpbeyJuIjoiRUNJ?=
 =?us-ascii?Q?RGF0YSIsInZhbHMiOlt7InZhbHVlIjoiTk9vckVBUjk5In1dfSx7Im4iOiJF?=
 =?us-ascii?Q?Q0lKdXJpcyIsInZhbHMiOltdfSx7Im4iOiJFQ0lJVEFSQ2xhc3MiLCJ2YWxz?=
 =?us-ascii?Q?IjpbXX0seyJuIjoiRUNJRUFSQ2xhc3MiLCJ2YWxzIjpbXX0seyJuIjoibm9u?=
 =?us-ascii?Q?VVNDb3VudHJ5IiwidmFscyI6W119LHsibiI6Im5vblVTRUNJSnVyaXMiLCJ2?=
 =?us-ascii?Q?YWxzIjpbXX0seyJuIjoiVW5yZXNDb21wRXh0IiwidmFscyI6W3sidmFsdWUi?=
 =?us-ascii?Q?OiJOTyJ9XX0seyJuIjoiQ29tcFNlbnMiLCJ2YWxzIjpbeyJ2YWx1ZSI6Ik5P?=
 =?us-ascii?Q?In1dfSx7Im4iOiJJbmNsdWRlQ29tcFNlbnNNYXJraW5nIiwidmFscyI6W119?=
 =?us-ascii?Q?LHsibiI6IkNvbmZMZWdQcmkiLCJ2YWxzIjpbeyJ2YWx1ZSI6Ik5PIn1dfSx7?=
 =?us-ascii?Q?Im4iOiJQSUlEYXRhIiwidmFscyI6W3sidmFsdWUiOiJOTyJ9XX0seyJuIjoi?=
 =?us-ascii?Q?Q1VJRGF0YSIsInZhbHMiOlt7InZhbHVlIjoiTk8ifV19LHsibiI6IkNVSUNh?=
 =?us-ascii?Q?dGVnb3J5IiwidmFscyI6W119LHsibiI6IkRpc3NlbWluYXRpb24iLCJ2YWxz?=
 =?us-ascii?Q?IjpbXX0seyJuIjoiUmVsVG8iLCJ2YWxzIjpbXX0seyJuIjoiRGlzcGxheU9u?=
 =?us-ascii?Q?bHkiLCJ2YWxzIjpbXX1dfSwiU3ViamVjdExhYmVscyI6W10sIlRNQ1ZlcnNp?=
 =?us-ascii?Q?b24iOiIyMS4zLjIxNDEuMSIsIlRydXN0ZWRMYWJlbEhhc2giOiJMV0FcLzBT?=
 =?us-ascii?Q?WEh4RVdmR0ZiV3Fsc0ZKQUpKYXk3TXpRVG5wdHZMVGkzSUZvM0lwYnpQYXNF?=
 =?us-ascii?Q?VDNIOEUyVk5VWm1RZiJ9?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Teledyne.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR14MB6811:EE_|BY5PR14MB3846:EE_
x-ms-office365-filtering-correlation-id: 6b8c13bd-bc02-4e1e-ef54-08db743358ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N24mxzoa1wDqbDK+lMmwyO6syHyCRJ0Cr/Gyz1WyUsGNS986GITzg/G1L3CxkkhiYMFWRk2J9dOiD0LZdh7zQqPFmuRhjNL82lNmfPEeKB0lE+yeceuME1WHn941Mzs8w9aCRAFqqiJpuDY43rux1v36/V6snMEnRBO5R4WCdcVlOSYNoeFw/lMLvGC/5FCzI5UhOJlAmIwOpI275WeXDeRrAR88wbjI8puafUUsYf3YqdR8+Y4p0SV8n9OQHHLbBimXQlXhYb1sWefq59bkx5THmGnbld0N8CjnNy1Uxo61W12aZiB7PLRMsJLn7D6xDyVS33guQXx85wNo7IcoVTcLCQe7d3RzFHosXApQsv88fxahcqNY7mYwHQUgSwgBhe3wYkvPcVVQf4lXIMCezp6QB+HslRyqzoGmkj1wUXV9fQaqoF+l0N8/pQEU/zGQrJXYsrzzjIJzXUrmzNOhrGGQz0kvZJshxiR++p9GFWCOB8llnLoTkHuyhPke/oEuIbFe2dvDAtIoYiALKayjRy5IjrNTDL2Q75VLkju0qySqS2QXMdp67AVVAT/ZEhqGlnvwt2SG+7/g6bxE7rjmL+IP9wFpA0sfjgJhK28Ha8JK+SvVNnvUKOqoRG0QqSrBs6vkDYRxwEB0/pcJWZKIUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR14MB6811.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(8936002)(2906002)(38070700005)(122000001)(38100700002)(55016003)(6916009)(66556008)(66946007)(66476007)(66446008)(64756008)(76116006)(86362001)(316002)(33656002)(8676002)(41300700001)(4744005)(52536014)(5660300002)(186003)(9686003)(26005)(71200400001)(6506007)(7696005)(478600001)(37363002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6qWvP8QaTYTxX2aqo0Swm9Or0uZQVW4ZSTTydFv5Gq6LDxOekYnhwzgNvXD+?=
 =?us-ascii?Q?qecpUBEZM3qcUS7+uTQQHBDrUd3m6ZuMnxQRkQKPk9naCLWJyca0oShg/vqR?=
 =?us-ascii?Q?lnJ3zaRNvs1yKhXnrOLXaVeBy2UxlZAoghDWSaKFPRIeuT+Vd4/wCe9+ZS1i?=
 =?us-ascii?Q?+umkZY8DHjoNQPil3ly1l/m+zLlBrPDDYJmofzY1wbkNbDOAwpqso4qU1wxw?=
 =?us-ascii?Q?JsPnwnF5sCp/lTjfGMaz7zDv3/KIyegS/HGjdEzXo1C0VuicCKK5pHz66Q8E?=
 =?us-ascii?Q?Y38Aw3RpzJ/TXiSRoArNRgW0xRJnz7r0PRQ/VXgbWLK25zu3cCIsVcr82uDq?=
 =?us-ascii?Q?RclXI7GZDAxZNhALvcVsInT99qgN+PwzUKkZB10j9OAUf1OV8pBUV0sLLsXY?=
 =?us-ascii?Q?UYIoSViSJOAwVaDi3+WYG6eUVkOCYAeblx9R2yUf8MDwPPyrlIqPnFlt23XR?=
 =?us-ascii?Q?bi7JtyCIxHboSd2iSCh8pHoDdNznNRl2K4lW2JOCRY+5Zj68BZeX1LVXDJs4?=
 =?us-ascii?Q?wk77oaHgUdcM0nY0drTCN4F2ohH2BGWDrXfoHOOooHPVZSFfbiNgL9OXvn3p?=
 =?us-ascii?Q?QVm9ytEucFZN6fUG2RrLeLszFMfFHK3A6RJaiQxN27uqVh35+XYLA99risXm?=
 =?us-ascii?Q?eTgJJECP9RMESvieIH7Fqh0p4n1p/qEjGkS0spN43M/4cWBmIvGWydgtvRH3?=
 =?us-ascii?Q?zvsmu1BxYh5HVww8K4gT8TBLn1Up8blouo+UlglNA8jL+cFTh/dT5tSmZmB+?=
 =?us-ascii?Q?Ij8AfLg3nndA346ZBYWPyyK+gPOvKJD+mnAa8p3Ttd+1ORbV20vCwojQIsa8?=
 =?us-ascii?Q?Isk2TENm1gkMKsS449ERR+D2F7eGexdv8OTonWNIGpKU8W72RBEdXunthxYa?=
 =?us-ascii?Q?ES2ya5H/A3y+TZivmHwef8PBCSqR08ZCqzRIgzSqUJsM72uv7bs2078Bz8RH?=
 =?us-ascii?Q?muZrPj5Ix6354meiZzPAt++CWkvy8HgcVR2EAwtavrfE2MlYdi+Q1kEx1yHw?=
 =?us-ascii?Q?CuKOyy5lXeleIhlIeO0A6d6ZKwZUKQF1ziq5XgUSykaw07g7QsIuu92+Liw6?=
 =?us-ascii?Q?Xymir/1NbMRqWMJQvivg74fozYHthxL0aO6unJV+ypQ7wwcw7zlB2BnRnIVr?=
 =?us-ascii?Q?kdQrC6BhbzxXWM6AChuw2tXq/7EuvBkk/GPDImjNyASr8iIIo81TSC2XGraD?=
 =?us-ascii?Q?mXY3mU07d7tMF0qbXmMtqAsfPPD1TfVxcalJmnI4SG/s2Euq0bZwrF4JcJDO?=
 =?us-ascii?Q?AzbU7mRur6cNGjwf7Q64H4cTqtXMYmCAFH9e4Ie8DBUynt3Mh9mV0ONLawQc?=
 =?us-ascii?Q?QZ39hqZpp7hylKKuv/Cw6s8jsDyGAEEZ/ne0rihNK6U1fkKIcUly5PLfkQTv?=
 =?us-ascii?Q?ADX/zT4Ijc6KX5sYkUKR8KaDxjUiX54FjqbCSZWnl+r8LVAxvPVbfmtU2P1K?=
 =?us-ascii?Q?0mnCeUrmtzBI2z3MjHVR87u8cn5EQxnOMeQ7/yHp5eRter0zHQlGcGkqyfU1?=
 =?us-ascii?Q?uIiSiQ3IpwFdGmOPuRl0FpRluVOHW/IB0xOpcS+OfOhJ4YIc3Y5EFX56AdMX?=
 =?us-ascii?Q?DL/pcW+K+jhDeYVfFO74vPLNq0PrHDghqUt6dUvtaK3Co7RziKMHhrpz2zUU?=
 =?us-ascii?Q?FsFwSmRAwQWn+EN/hRLTXtI=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c48/tgVidwkAFLvqnM+II8i+fgpEI1IjVTsuDNmDwq4f0Hz6S4GDgODIHWYAHBd17Oak01CwDJvswPXNKlIg4TdDunYNGTYWcyWpPsKSIb50SJMWQCD2zBccXB+AvnJs9YffXSVv2Fx+Myuz6WWpD0Srg5ersxJQiLdRAZdfJXbH1K7p5TRshGchqaFACq2dEi4zSxKCINYNUTgee9M6KJniU7GJMHhs6X4UfopcyMYolckPjvCQJVVqeMtOrvtGIbJJ32hAHP65LA6HBl+he37vtWLiLzaXtkZKfgQLRgp/JxesubRbu0PC6nMaRi8xzqZOGFljyxSKeVLQkiQU1g==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDo9ug2YOo6pMZrY929f2WGbS3pFbeoIpcHWRmdG6fE=;
 b=oQZihSExhClxAvtBFEEfqCsA4/TFc1/mNH4yAvmMrwLAwTZxAWIJuR8coJN8fU6wocVBWvh/HS3C3K12RH/ss5v9PkyYJVIQh2M2pXchcBCz2UED3pClOrskQn+/SS4ge4cChNl/pRX/X7KMSu3d31OUU4+xzEVcmpiMCdoGVIJIbRuNyMJZYWVEklA4O1C2vKD5YbKLsDGxc4YLGKAdtKIMhf2wE8gQsE0rHbOT33Pore/vidnV4/MberUDTv8MxkTRY1vG+43nPkct4Ib5mPsahwqGxpGJSRUCGymQKI4bgjkN3P6q0emLx5ABZSd41XNLNTHUYtnDy80VZSbF0Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teledyne.com; dmarc=pass action=none header.from=teledyne.com;
 dkim=pass header.d=teledyne.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DS7PR14MB6811.namprd14.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 6b8c13bd-bc02-4e1e-ef54-08db743358ef
x-ms-exchange-crosstenant-originalarrivaltime: 23 Jun 2023 21:46:48.7011 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: e324592a-2653-45c7-9bfc-597c36917127
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: sBqUh7bNwWdJa8TMZOsEro5hSElPfGZwjFEs7oC94gyAW6ZlwBk3+vRL5Hkp6K4BTFdLL/KY9AY+UOpa1XxO9TMSMzofzuLxcdT80zZVkK1FSm0PnOOT8ZB0R2x0Z1Ir
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR14MB3846
x-originatororg: Teledyne.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Hello,

Hope this is the right place to ask this question.

I need to be able to check and control CXL 1.1 device capabilities in appli=
cation in user space.
Example is to temporary prevent device to go in low power mode.
To do it I need to be able to get an address of RCRBs

My approach is:
1.      Get the list of the cxl 1.1 devices
2.      Select the device from the list and find the RCRB address offset fo=
r this device
3.      Use mmap and test, read/write capabilities according to the CXl 1.1=
 spec

I solved and tested 3. But I manually found the base address of CXL 1.1 Dow=
nstream Port RCRB by running
ascpidump -n CEDT.
While this is ok for testing since I have a single CXL 1.1 device on a syst=
em I do not think it can be adopted to work in general case,
when you need to choose which device you are interested in.

So I need to solve somehow 1 and 2.
I could not find the way to do it with neither lspci nor with ndctl and wou=
ld appreciate any advice.

Thanks for your time.

Regards,
    Alex
