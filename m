Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADF24B34
	for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586461; cv=fail; b=gLgfUJQvJbaZ+bRvJIN+4wwedqm0AOGbbPUxgKdpyWXTsXZf0GxADIXIC3m6FTnbtW0JN/MQcUaxXdM0pg3M8VaXlMH1dJ4djyMLL6vD9Cj4Ql6y3y/e6i2472KVwzLSEY5jyYac51DhkzP1lQnxWLt5GC4i/TScOGLOxj8uAOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586461; c=relaxed/simple;
	bh=mzlq5MGbvUpNtNGP38NXb7V4e7Tt4VLXqVzCONlqrIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X3+9nOgr/eYuuHw9plDVA4d11Q6RHz41F4OrRRboIaXY2Mg4QiX8CfcFzpcFPqo3tIo8KwK8tZebJTom4+FTTYLZrfA1WjFFihi7hrQVgQ/0Dpvh6nzdGMLpVUxadetnmU7ViE6jY1Uvw7MrTMhNqK322vrgJJkLLhoiIxB99WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SuvRhoeO; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SuvRhoeO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741586459; x=1773122459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mzlq5MGbvUpNtNGP38NXb7V4e7Tt4VLXqVzCONlqrIQ=;
  b=SuvRhoeO1DsOB+3O6QsUplk9Ie1lhCQEkn/+EzmoeyegGht2Efx38xAn
   PaBHVoC988Lnc2iCUMpj6zwNV0arNDFK6HPyIM/HP7LONTPcKGk0j+oAW
   Xj3HogAc0/gkc4d0YZTTkhNNVGGm7cs4lLWu8AKETtb9dSoC7KzXAguDa
   wzfroSDe3v1Ucbvo9EhPMdmh2xBBEEBwPruaetmq6wOxX4wWPTSXt4tPV
   /k1bST/7gFa/8NKQwjhjrcVlSBWLN10F7ptU794N74/EpP6fw35Do86Ci
   77teJ4iAnbPJDrA6UOLUsVN45OGo6KRCeCSuaj1T43KxfNZOIc/5dLX0B
   g==;
X-CSE-ConnectionGUID: k7suIrQkRgu5j0KvKSO08w==
X-CSE-MsgGUID: 1uRb8O4UQ6yndwIq/Cn8zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="61841604"
X-IronPort-AV: E=Sophos;i="6.14,235,1736780400"; 
   d="scan'208";a="61841604"
Received: from mail-japanwestazlp17011030.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 15:00:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iX0ztKuK2+mGXTw1u+DD2YtSROCV2nItDldkyoP6FDuqc9xY2shrFVWrcRr6PSJ3S8o/5w0geGmZv+5x9Yr2IvK0vR8usGruEQUvnRpaInqFSVlEzI2smjqnhDTUmkTQ7pyt39cf/vQRkAOQb3Wvz39TNCodZnE7wh1GkQMdnsd/lMlFaxfHbLUsZzkgmuC7FGCjtKWQ4+h/KJZU4IeDKdRsr0c+4m90vjnWk7AmXcxrzMEd/4wDfEnn+mK6G+cwKQuBj83weH1KtxLL0hT049z7CK6W8Y1Wf3B0pcJJrtiu7ARg0e+45n4x1xZbyY9cowNRK4iO48k5me1eCsmPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzlq5MGbvUpNtNGP38NXb7V4e7Tt4VLXqVzCONlqrIQ=;
 b=E5tDpbQeIS36uUZIMuYW8epmAzqN9Rn25fYX1YB276n0vfJ0rQJjpU+0eWraslR+ZLfI8bdNUogMwd7pmH2ujkg0AX/NOuSxsLQc0EHvvZXy8qJpiTplL/EVgu0Vx3uuZfaJCdQYos3FzmN4C5Yzd7O6v/oKY00RRcdNb5doNxRcaqlFSFeVx5IMew7/E+Wn5GuJDJQcCF/el9+gMm8Bj10urqLBOK/SGvC1ijYuJqiZqVYQU8UsQdLl+saflVbK7WOK7rADy0eCYqq81MkXzlsXnX0FMmSI8F4x6F7Bs5SqsAstS5nfCHW058tSVpaVqvSWTSVoNL6kxQ1WhGF7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB5879.jpnprd01.prod.outlook.com (2603:1096:604:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 06:00:46 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 06:00:45 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, "Fontenot, Nathan"
	<nafonten@amd.com>, David Hildenbrand <david@redhat.com>, Fan Ni
	<nifan.cxl@gmail.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "gourry@gourry.net"
	<gourry@gourry.net>, "PradeepVineshReddy.Kodamati@amd.com"
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
Thread-Topic: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
Thread-Index:
 AQHbaD4SNAeoR9FhZ0CNhDBQza/56LMg6dmAgACyQoCAALongIACNhcAgAY17oCAAETcAIA8c7EAgAEfbwCAA5i8AA==
Date: Mon, 10 Mar 2025 06:00:44 +0000
Message-ID: <4868f2b0-bcc5-4cad-b5d5-32188350f145@fujitsu.com>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
 <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com> <Z5CKN57paDmGJH9A@gpd>
 <5067fda1-c2de-4a20-9025-ebdf90ebba8e@amd.com>
 <9b0fa1f7-4133-4111-9142-143c36c42f8d@redhat.com>
 <69701a1b-8cec-42e5-90dd-1b1c67c91823@amd.com>
 <b5f46e35-c3a8-42f1-ba30-b7c43d2bdd89@fujitsu.com>
 <3ed69bb2-3c93-42c6-9f02-9519482b112c@amd.com>
In-Reply-To: <3ed69bb2-3c93-42c6-9f02-9519482b112c@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB5879:EE_
x-ms-office365-filtering-correlation-id: 53ce19c6-6cf4-4456-a592-08dd5f98e549
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUdtbjNHcTdTVS9nWkEzdTR6a3ZFb044U3VrZkpQeExlUnlpc1AydHpXZTV3?=
 =?utf-8?B?R2FRQUdPdDZZNWJ1ZmdYaFBwMlpVUmhJUTFzdStVSTg0eGdrWjRyREloMmRn?=
 =?utf-8?B?L3lmdDA2TjJkTXArQ3locGZDb3RESkhQbnhUWDl0YTRJZFpiZUZ0VU1EWnhh?=
 =?utf-8?B?WTJpM3hSR3hPbWRzMXliOWViZ2RpbzFsRmlwYWxiVUMvSVRvUEprK25LbHZI?=
 =?utf-8?B?eWVYbTF1NkUrQ2h0M1dxT3REUjNaRkRuNURsdGloVFVRRnBPNk5ieERTS1dx?=
 =?utf-8?B?aFhBSkZVc3BHWG8yRUtia054RHJLUG9JQzZ5QjBpa2VmODQ4MEdlZENJdFZZ?=
 =?utf-8?B?bEkvTGlGbUc0UC9NTWtaMVJvWnZNVkVtVzNtWXFJZ2VyR1EwTkZkQ2wzbEJF?=
 =?utf-8?B?aDVBcGtmMnlpOEJaWmJNWUhtWEo0eWd1d1NtSjV4S1ROdFlFZEhVZk95QjN5?=
 =?utf-8?B?NHUrMUFoRGJrZmFYeTJyQWN2RDh4d2MvMGlUb0dWTG9zSGYwYlNrY3Vsdmph?=
 =?utf-8?B?cjZvNWJKRzVVVFl4V0I4YmFnQjNNQ3B4MFl3a0paQ0JtanVnYmdhNStEKzNq?=
 =?utf-8?B?UDE4VzZlZTZYQnRSK1lzM0dSVzUxN2RZQzlXMUVRdTArUWs0MkhWZEk5RmxF?=
 =?utf-8?B?ZnU1Slk2MzhXckRYMk1McmtQaDVhdmdWc1hCRGoyeU5Xdi9reTBLcjR3Wk9h?=
 =?utf-8?B?S1dPcFlyTXpKd1RSMzJqblFkSW9yQU84V3JoTnZSV2xrak54bWJTeEdzL1JI?=
 =?utf-8?B?dnhXdEFaTE13NFpYejJUenRNcEllOXRNVkthSldHV011K1NtQ01KR21RNnVt?=
 =?utf-8?B?R1J2OFhTK2tUT1JRdndDakMrSXczd1FoM3F0cmw2K2laZDIvd3JXY1lYUWd6?=
 =?utf-8?B?YVJ6YSsrb1IzaVZ6TXBEaERpRjRrdDBPZEhHUW9vdnMraE44V2JKQmhOdmJX?=
 =?utf-8?B?UTFTTFpKalN3VTRjcVp1TGpPRi9kbXdJQWNxR253RVYwbC9FazlXV2FYVzZn?=
 =?utf-8?B?eXpxNFovMytyT1V0aUd6Y3V5bElkZ3VrZ3FhZDBheE5oNUtSUGtSQ0ZaOVRU?=
 =?utf-8?B?RFd1UzM5K2dORXNST0ZKZzlaS3hXM3NxaDFJcHhaU0F6V3k5eDFKN05MeHRl?=
 =?utf-8?B?V1NUcmRENGxQMDYvelA2U1NMNGFON3V3ajQ2WXB2MDl4dDI1QnBmNWFtaks3?=
 =?utf-8?B?Q2R5K0tBTzhqampmQUMxWmVKTTM4Z2c4ZTROZERiSG5oU0d3QUVHUDBJZUVT?=
 =?utf-8?B?TGFMSnZIR1d2TExNMUFSTkRUcHluU1QvejdNS2ZxMXVrNUJyZHByWklueHlw?=
 =?utf-8?B?NTFJOXR3M05zNUg0ci9ES3hXS0llbjdvQ0cxRWlKSi9WS25qbEhXYTFGemxJ?=
 =?utf-8?B?aHd2dmJXMnNiNm9aNjV6Zk1XMkorR0k1amhzRWozTTUyQUFIeWlMcmpWMXFX?=
 =?utf-8?B?ekx1Y3p3ZmdZeFVzSXd2VXZvNGl0a2xBM1dWUTd2empBRkhuSFVzUyt2dUVP?=
 =?utf-8?B?eFR1VHF3M0FNdS9VMWh2RW5XZW8zM0UzOHdGSDk3WSs3WFVVbXhDT284eUpD?=
 =?utf-8?B?cGJmNlNEVzNTL0tmeFJZWWUvYkgvUEw4cWRFa0tGeUJwSG5SRjZpVmVUaW1F?=
 =?utf-8?B?eG43WDk2c3htdWpMU3Ywc0tWQ09SWTkwS1VyaVQvMmoyMG1ZLysxOFhuZU5X?=
 =?utf-8?B?RVE1eVo3RDRpcCtiZmY4c3RaUi9QMytoUVBvaWIyKzhOQWJFbUJ0ZnJOWEJL?=
 =?utf-8?B?ck5sSmxjcHNxbWJUODh3aVFSYXJqNmh1RGFPVFBaMTJIZjhyRUc3QmhISklJ?=
 =?utf-8?B?RWRZbEkzYkc5SWRBdGhEM3RkVUNPaGZvb3JKRkRQSXBGY0lpb0RmckRBYllO?=
 =?utf-8?B?SUsrbHpQYlI3M3luYWlYRGJVK3R1ZkRGUDQxWTh3Q2QrVmJEbUhlOStCeVJO?=
 =?utf-8?B?UWRRR3NqUUJZQzZjYmRDQVdiQzJzbEt6Qlk2YTNseWZPdWtoWEtGaEdPeG96?=
 =?utf-8?B?ZGFERk9IaHlnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vmx2WUlaeVJuaUhNd0pBYU5FZUczVEs0Z1pleWR5VGFxNVArOE13cXFZTVlI?=
 =?utf-8?B?OEZFTGk3eEthTEd1ZXhTN2ZqSXBBT0lwTldmL2ZOZk9zOTN6dHF6NXd5bDNZ?=
 =?utf-8?B?NDZMSWZKM3BsbkZiWU80YmZBdThDTlVRMVJnRDlHMitoTEVwNy9MWEFoRXVG?=
 =?utf-8?B?c2RGMURkQ0tNWEd2UWNoNjZPSGlPckpqalV1TW1mMmorNWM0SXFSVmloL1hk?=
 =?utf-8?B?QWhIZXEvdGpjbjhjcWlMT0pYRkpjdE9UWmVqN2VzUU9FcHBYTDFuWFg1ZUJE?=
 =?utf-8?B?R3JaYWhmVjBXWGkrYzRsNkNjUEVtTi94elhVcXpLR2JyM2JhWExuTHA3S1o1?=
 =?utf-8?B?MkRvNzdFRkJpWmQxVnZob1JqNXQxSkFoTkVraDJzcnU4cVBVcXZEWk5pb0t3?=
 =?utf-8?B?WFplUHZidlFWeTBYeW1ERUlTR1IvVVhWb0prREpZTnJVSmFZRzlOZDZGM2dr?=
 =?utf-8?B?eFlZc2poUW9vdHF4M3dtbFQyV3ViZzJFQmg5TGFCMFlrV25wOW9pMkl5L2pO?=
 =?utf-8?B?ZkxSYUVoY1V3b3hESXRlanNvcW9CY0N6VGl3UUoxck9CZDh4U2o0SktQc2hT?=
 =?utf-8?B?Ky9qV2dETHVLR2RXd0UvcTlUNGN5YWtSb3lsUktuZlZSMHVxbGpCcGwxMUZz?=
 =?utf-8?B?VkhnMWZUTkw2ZGJHVzErdzZUMkVEcWRWN3k4VmJ3NzY5dGwzK0FqN2IvRm9i?=
 =?utf-8?B?bTN6SzBaQkdLV0FGRnZ6UVFNTU55Y0d0MTV3Q0tRSmg3MGN4OHhjQWloSWo3?=
 =?utf-8?B?Z3VOak9YdE5CZWJtZXBzb0NFMnBaQjIzallTdS9DT2tGSGxWNmF0a0JuOTlK?=
 =?utf-8?B?Y0hnRGtvZ3ZNaW9JNENDMjYvbnprUCtBdExsclFMdGFkeVFUQ0lPU0ZzZnMx?=
 =?utf-8?B?WUI4dEY3Mi8yaEJ6K1VFSHcxdjlFUWlYdVZmTWp2MnNoQ0hZakY2TEhCVXgv?=
 =?utf-8?B?QzB0alhxaExZcDBrUG9FMXdYTmE4QVNxOGIyT3FEMnZmZWsyT28wc3VPQi9t?=
 =?utf-8?B?NUxSM05Kbkp4MkpXYWlwY3FFalR0MG9vWkV1ZGpIaVRReDIwNDl2bElIc2ti?=
 =?utf-8?B?QXd2Sm9HVzlZb1UxQ0xMMEtjRWhRcE84NkQ2TzgycjcvYm5YL1ovQVNIOTB1?=
 =?utf-8?B?R1V0akM1ODhuZUZGV2crV3pKWEpTMWJZNi9xVnIwalBDa2t1Qm5oK2hPQ1Vv?=
 =?utf-8?B?K1dWUSswTmFuTzBHNmh3cE5UaEhTd1pXamdzQlI1MURObDNRK0NQT0Exa0NX?=
 =?utf-8?B?N1pJSVozSkdOcElEd1pBWGxsYnprRkM3Rzl4QVd4VTFwMURSVWYyMjJnaS85?=
 =?utf-8?B?RDU1NW9qM01CenRGMkhmKzdSRU11dXJVdVdIL0VFZVlBWUZ6dVNJa0lqOXJi?=
 =?utf-8?B?Y2JrTkFWQnNQUzlIcFdKL3ZKSzljN3R3ZFFaWUNBL29zSXRCZHQzZHBqWVhj?=
 =?utf-8?B?S1RJeE9TWTlXU00yUTNOUkg5WUpXanlUak41eTJKb281bFFjQllkakZISlly?=
 =?utf-8?B?M0JCM2d4d1VwVDJtZ1oxZmI2RnppY1U5TXEwMkhrOE14VURCTWlyaWQvSnNP?=
 =?utf-8?B?T1JXRVI1QmUxdjdyazhYZ1FmaUJuZlRMZGxVKzlVR1dlaGtJZmV4SUxWMURh?=
 =?utf-8?B?alBpb3BIUXZMMWhoZmdod0VsSS9UMEw2T1RqT3pDdHJHaS8zZzlReTlqbjF0?=
 =?utf-8?B?OXBXWVlvQVVVRTZpWHpzbGxSQjVWSjg2NndUenFCZ2RTUFdEUDdVZldGSVlQ?=
 =?utf-8?B?SEFYS1JJRWdHOWlzcXoyNzJNaHJaVGw1YktIeXVKM2tsUjl0a0swVkk2VDd3?=
 =?utf-8?B?TUNCUGtCVFNyWUhWSzVWN0Rwb1pNUWxCZDdJSUt6TlRTWDR5QXl4RUFZQUFV?=
 =?utf-8?B?Ky9lcnBCcnVHakV5NlVUR25kWFNqNElNYWR6MWZUc1BkczY0d3I3dkdwcmJs?=
 =?utf-8?B?Kzhkbk5GWmkyRHZiMTFMUGZuK3poYm1ncVNNNUxnVGhhNW5mb28zMWx6MjFR?=
 =?utf-8?B?L3FjdnVVK0picWtiQjlDS1JpVi9nSGdPMm52NHhBcGJQYWdDTHZ3dmwvdU4r?=
 =?utf-8?B?dWg3Yk1vKy90T080allGbVFSMFE3ZkFSRnNQMkZKUjNmeFVuNUJ3bzlzRUxR?=
 =?utf-8?B?cGtUZm5MaHNiL2JnWVlQUlFIOW1qS2hyM2d6M3NBTW9jVFZXN0d5Y2tDVW5P?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBEBE68103AE6D439E51FED7345F0367@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UGCt/grvUjyh7yT66Ec0tQYrlro9xUHBw297cU34mZGydGVT2ysiTiy14eMErglu6eur9pHkn3kombQo9X2N5WZ5cgqMYZwIIFkX6x98VisAHJyesGARUkOiHa4ms2H4RGAejYsaGG1OoTJXXgZsXAoXuVNsXdecVWx6a2HrYwc+iY2XUp5aNZ+P8zZOvLSwR5OoBr/WGtb0cEoOHRZdP1zB64onwbic7OpEw2+Cm8DSGiFirsZD3wOZRIAMMBEJnZg7WPT3+586pcaPL7tR891nszRYAsNnV/Oh64nHUOHTxSXANFY2EScjvmwOSeVBmcLs2xQw+/4UJHA2afD+vQeTVDJi3m5a0hyU3bN3qbmCEiZOoYddLeiQ7b6ftMgQS0EAuNoWYuD7b6DBWDDt1BAeuAdMZvzrsMIaWUatXBL/bsoLudKjByQ2L5inawKxW8IW5pLNO7MZ1CVYFkEFGs3IM9RiI9hLPpVydlVsfsPb8W2lir3XIiZwhF7kGnm/ojuSOm9BbaOSlMhSfinxuP282VtlyHZqMlz/BDD0v/2shCMhliagrPrhVRqo3MbufeNf9XRiXu/BJXSUoK6OR4B6N/YgTW6R7pUIjX1z7Lhl+5+ulfEhGQgq76GEx7Wz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ce19c6-6cf4-4456-a592-08dd5f98e549
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 06:00:44.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQQduOc4xqVplww0VnZha9ZPKsmCI2cb96sViPnjNlheYuwk2eLYL/dH/tLy+G7wypSf+2VUUW6a1mbgZj1a3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5879

DQoNCk9uIDA4LzAzLzIwMjUgMDc6MDUsIEJvd21hbiwgVGVycnkgd3JvdGU6DQo+IEhpIFpoaWpp
YW4sDQo+IA0KPiBOYXRoYW4gYXNrZWQgbWUgdG8gZmluaXNoIHRoZSBwYXRjaHNldCBzdWJtaXNz
aW9uIGluIGhpcyBwbGFjZS4gSGUgaGFzIHRoZQ0KPiB2MyBpdGVyYXRpb24gcmVhZHkgYW5kIEkg
cGxhbiB0byBzZW5kIHRoaXMgZm9yIHJldmlldyBuZXh0IHdlZWsuDQoNCkdsYWQgdG8ga25vdyB0
aGlzLCB0aGF0J3MgY29vbC4NCg0KDQo+IA0KPiBDYW4geW91IHNoYXJlIHRoZSBRRU1VIGNoYW5n
ZXMgZm9yIHNpbXVsYXRpbmcgdGhlIHNpdHVhdGlvbj8gVXNpbmcgUUVNVQ0KPiB3b3VsZCBiZSB2
ZXJ5IGhlbHBmdWwuDQoNClN1cmUsIHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGUgbW9kaWZpY2F0
aW9uIGluDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTAzMTAwNTUyMzQuMzcwNDU3
MS0xLWxpemhpamlhbkBmdWppdHN1LmNvbS8NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPiANCj4g
VGhhbmtzIGZvciBvZmZlcmluZyB0byBoZWxwIHRlc3QgYW5kIHJldmlldy4NCj4gDQo+IFJlZ2Fy
ZHMsDQo+IFRlcnJ5
