Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95E0217F37
	for <linux-cxl@vger.kernel.org>; Sat, 26 Oct 2024 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729905011; cv=fail; b=dQaR9CHjsQjRhWYLIfBjA+XWavK+Y3rKVKcm0/vzjFG2B603YVXtHZ4/NBB+SOtA5MK+e6GHk9EsMbh0FvtkvrUqAmhUb0XR4SVRC7BL+B6cdYqLKadC4CmqX6jire827qNSyQxq6fXp+wlZSltYtJQiH7SuNC/n3M72kMiqHyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729905011; c=relaxed/simple;
	bh=6tWK0AoLg0P5Ahx9DaBErBroWeKHy+D6XFrxXPUSE0w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e0tLeBDDM3ZpqwW3fXTiaV7U33TAHG2/He/jdGAsh/4DVmVXPuPpxz3GSd6IbGihtwa12jCj6PfaIOAWI2GNg+JyFwvcGkbuhR7vJ13e91uKdMuzBIjK+9bV/Nr24FZxyITsowWGxz3H55YlVVuyq4KebYMxQ5952BTgxeTxsls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=BaKRkXbk; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="BaKRkXbk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1729905008; x=1761441008;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6tWK0AoLg0P5Ahx9DaBErBroWeKHy+D6XFrxXPUSE0w=;
  b=BaKRkXbkqMez5vOCrJ7M1+HTw2soHH8+1rxmoV2JzTHMkqr6Kppp7UX5
   yA+QzkixyH7D7NW3hgPXYK4rXh15CuPVwTLrq7sWqcvb7UucsoySXrI9b
   DdkzZHkCGgsswX0GhhH5soCT9Vjdu2PXRn5AjLYME8btg7QCoYrMg1M0H
   rgKX++0JBJpDkN9qwySPEKf8RShep5EP8r15CGb7gf3JHYsmFkShYcKjj
   wlVR+YYwTq9eJz67P8CeVDDDFDFyURLmff/VO3pVI22j6mZ0MHEE2gB7L
   lMflqykXES6YOFiIX9BACiBiCmyv4HVSDPB2/0J6ocxPoc5qKrYzpxXAq
   g==;
X-CSE-ConnectionGUID: W+dpS2e2T9i1HZjaC31p6A==
X-CSE-MsgGUID: WuD1UUE8RKaPQlLQeiXPHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="134419212"
X-IronPort-AV: E=Sophos;i="6.11,233,1725289200"; 
   d="scan'208";a="134419212"
Received: from mail-japanwestazlp17011026.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 10:09:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivYNCs8Gdw7lqOBN5wi2+SVcKjklG3BBrlqwXVehEkQV2jy/n3HTBY64F5pGgdJ8SMzy1lxa+3Vk+/MW5+Tux1oVuYr8s9XDnIGW4SKC5nOWG+dMw1iI7W/h27C657YBamF0UVQvbKaf952TgzK2xNxjXpIQV7dYiLGOf6lLkuSbxn2IV1xtUYRK4ghdxAUY6BQy+i/Ufb7x51MTELdZSKujOGq4rGh/o+UyRaZY6DSs1jR3F0/t+zpK4eFI/YatTzKTAdYD36p2b2xWlDMKoAX3vLCcji/XMAttrW20nBNy67M3sHxhrh/AvbJ1pRfdtW18gt0V4j28Md/KjBrOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA9/0ulC11mhjKW9LnYHbIUUfQc4QyMPF9D6/KgbodE=;
 b=Lc1IYdWLTuxl8IyYsYNa/ikM3SHpzKhQwT3zkY0CXBA6SG0KpT9WxSaRYExPANkWviINL9UPjB+aJVWN4OmYI2JHcf0r7vdoTrf3Q5fnUJYQzPU5IU+MB0FJaQHO1YD+YRfTnCn6xGVSXR6z/fvM0HK5VM0AWkJoFJsLZMuLLEzc4xzbTtD1TzlBNnB6HeiUmAKgGYfJJE+MJf7Z7QOEWkR6ABiWSZvCNVLqH+acEjL6qvNlAIMOgrWg8Kh5Q9VA+H2ceoXrr3Lq/NQ5b5kDTWr0VHX62NMRyX+BzQEMJ3Ufr8KiQR6eKhPWt2wD4THoHL+8AH8o0Uo5jRtwhksW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYRPR01MB12335.jpnprd01.prod.outlook.com
 (2603:1096:405:105::12) by OS3PR01MB9498.jpnprd01.prod.outlook.com
 (2603:1096:604:1c9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Sat, 26 Oct
 2024 01:09:55 +0000
Received: from TYRPR01MB12335.jpnprd01.prod.outlook.com
 ([fe80::18b4:fae4:bd97:f2b7]) by TYRPR01MB12335.jpnprd01.prod.outlook.com
 ([fe80::18b4:fae4:bd97:f2b7%3]) with mapi id 15.20.8093.021; Sat, 26 Oct 2024
 01:09:55 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: Why does cxl zero-label command fail on my QEMU CXL environment?
Thread-Topic: Why does cxl zero-label command fail on my QEMU CXL environment?
Thread-Index: Adsjc7cNDaeOWzIhTh2tIzh5mef73ADswXqAAAZNTrA=
Date: Sat, 26 Oct 2024 01:09:54 +0000
Message-ID:
 <TYRPR01MB12335AAF060E579DB251E4D6B90482@TYRPR01MB12335.jpnprd01.prod.outlook.com>
References:
 <TYRPR01MB123355935A2E90A320934E3ED90432@TYRPR01MB12335.jpnprd01.prod.outlook.com>
 <671c10af9a6f2_10e5929496@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <671c10af9a6f2_10e5929496@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=85b32242-5ff9-4ad7-94c2-88631cc510b1;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-10-26T00:42:33Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: d47fb71e5c1a44d0a099c21d9311b521
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB12335:EE_|OS3PR01MB9498:EE_
x-ms-office365-filtering-correlation-id: 37d3cc37-0fb7-42e9-c9b7-08dcf55ae67c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?SFlNTEhpVWZVQkJDekhTdEhHbXNQWGowdENHTExTS01PWDRDVVliU1oy?=
 =?iso-2022-jp?B?RjM0bXBCS2FsdENxSis1ODBQVjdFUmZVUjdsUDg5YytUbFc2Z1E4RG1E?=
 =?iso-2022-jp?B?eTlWQ01wQXhPaXpYYjE1RVdvQ1VRT0MvK1F6ZkVGSHBCbDk3WEw3amZC?=
 =?iso-2022-jp?B?c25qUXptTDNjVDFkSkhYNXhpUmZOSTdMdGU1U0lVMHc1TVZwV1YzN2R5?=
 =?iso-2022-jp?B?YjlxeCt6WVZqQkVldkIyT2xPLzdRbUI4emxtM3FHQnZmRDBFRkt5SUgr?=
 =?iso-2022-jp?B?TlBKVnF1SmpRZkJxTFgxZWcyNFNYazNtN3o2Z01JVDNMM3U3bmRWcU9T?=
 =?iso-2022-jp?B?Y0dwRWdSWUNTdGMvd1NJS3VuVUlBTGRvcVpVRVNwclJqS1NqQ01PVGZw?=
 =?iso-2022-jp?B?dVlLTCtMVlRBa3lhQTQwZFBqMHdqSUxaRFRPWlpSNC9TQmVtcVVXSWRS?=
 =?iso-2022-jp?B?QWdiT3Y0Zis0T0pmRzVveThsV2pUeHQ5WGVYQ0dWenFybERDTkppUk1m?=
 =?iso-2022-jp?B?dHZkbUFwNDVHd1VqT05takJ1dWtKWkZpVzdMbkVjVWtPaFA5ZDVmQVk3?=
 =?iso-2022-jp?B?UStIbThVYUxMZHRlOWF6KzkvV0pHaE9HeGRQM01zTlk2clplNkFlVFov?=
 =?iso-2022-jp?B?NnNBUXNMUGpBV1hvWGRzeWxYZHgwSysra1RWZUZqQ0ljZHJrZWhXQlk4?=
 =?iso-2022-jp?B?WHUyVmhyRVp4Y1pUNTI3MUhYb3pWTU96cXhLeUpHa3VKZC9KNFpNZnVE?=
 =?iso-2022-jp?B?Y0lpbjVpZXJYczA4d0w3Z3JraG1OMWl4YzNKeTJVclpJWGRRcld3NmpK?=
 =?iso-2022-jp?B?Umd1REJRRGFrRmd3aGljVjRwY2F3R0RBQWs3VXBrUHhhYlNFQWdNZm5N?=
 =?iso-2022-jp?B?UlZoZ29iU3dkdUdmVHhFdnU0ek5oR0VkTEFYdGFNVzZSMEE1d3M3b1l6?=
 =?iso-2022-jp?B?NXZmZHA1L3Z3dzJGc0t3R0lzSitJSUROSnc3d1hnbW5xeGhnTnVpbXRG?=
 =?iso-2022-jp?B?TCtiTjFHL0Q3VFUxTnFtTlh3anRBdVdqakZMZHJ6MkVNblhRL3dLaWlY?=
 =?iso-2022-jp?B?dko1NlZJbVAxMzFaN1FmeFNMbit4U3huckxlN3pFc0hKVzhNT0czVDBO?=
 =?iso-2022-jp?B?bGZRSWZDeVFnSXRWc1VkVkR3ZjBTVmEwV2pZWDltL1NwZjd6d2NBNUhz?=
 =?iso-2022-jp?B?NkZpQ0ZvZzZrNHF3bTNESzJCWkdtSHIyUHBCTUxtenpkZnFZczZNbHhp?=
 =?iso-2022-jp?B?N2VUT2Rsc2VVZFJRL2Flb0tjbUIxYlRLU0ZydElwKzdJMTNnWjE1TlJY?=
 =?iso-2022-jp?B?RlhBaCtlb3RYbldBVkxkYy9CekJudktGNXcrbURlTHNFNVY3aUovSHVp?=
 =?iso-2022-jp?B?Y05WamZhanAydW0vL3RlNG1vUCtRZnhLcDA2VXN2d3ljNkZ2QW9BSnl3?=
 =?iso-2022-jp?B?M0pRWmJzTFliUmFpUTlmeFg0dWJoRUVyWGRGc1BTUGJJcnB6NWxqRXN2?=
 =?iso-2022-jp?B?MzJUd3VJZWVQR2dzTjlrT3dLWVk2UTNKNTZZcFU4VXdOWGJocG9XMEo0?=
 =?iso-2022-jp?B?M0tOc3E0K1BwWlFFbUhnYkw2bWM0YU5iNzRXYWYxY1p0NkF6ZWg4dzZD?=
 =?iso-2022-jp?B?Q1ZFam1xbW4wNHNnU0VBMGpCYWdyMHNjSXFxd1B1cUcwM2JZMERIdW5i?=
 =?iso-2022-jp?B?SmRSbW1aaVVVODZMb1E3bmtvaXhUdWtML2RxK0Nyd3lOdW1PM1cvaEw1?=
 =?iso-2022-jp?B?TzRzMXRldGdqSkx5L0xNRVBzMXlsZHc0N0RLK04ybEU1MTV5V00vb2ZG?=
 =?iso-2022-jp?B?YmRhVlI4ZXNJMDNOU1UrOEs0cGplcmN6YjhKeTN3TmFUbHlFenZjYzF4?=
 =?iso-2022-jp?B?OTFBYVVzNTVLaFgyRmh6NTlPTURjaXZFQmxuWE9VTXRQNlRKV2o4aVo0?=
 =?iso-2022-jp?B?NHhZbnVVQkd3MW80NUM2U2lKNkRGOXJIYVJ3dEJ2TlcrTXNwNXEycDVl?=
 =?iso-2022-jp?B?SC9vMWxaZytPam9uYlhkL1R4RWkybHRuVGNZQ3lZY2Uwank1cDA3dEs4?=
 =?iso-2022-jp?B?NEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB12335.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?c2hFY0x0UUkyVlhEeWtiR0pwNWhkQloyMHZOcXprb1NJMlYwYm1ZV25O?=
 =?iso-2022-jp?B?RDN3UnRHVCtwY2xQU2J4cEpWSHp6RW8vRU1yaEwxTEl2U25VdGpONWFu?=
 =?iso-2022-jp?B?ZWoyZzJYWlZCYXRwNlFPQjJKTHRrVk1rcE8wRTJjdmFMK25NMFlUMTZz?=
 =?iso-2022-jp?B?bnVpbHNWT2pLeHhMSkxEWS9iVElQM1pSWGEvRTVWNERmZ2x3dHQyem1T?=
 =?iso-2022-jp?B?K1NibDgwL2VhUkZSdk1qenZmTVNUSjlSRzJYMmZWVWVMWFBVcXpmSk1U?=
 =?iso-2022-jp?B?SzRySjhkc2F2aGlJdjV1TlhreXRyam1HWjV5NFJ0MmhCbWFaMjZQSldV?=
 =?iso-2022-jp?B?ckV6MTFEOWRzWVR4ZldoM2NBNWRERDBjcUp2bzVJZ01YaEczNENPWld1?=
 =?iso-2022-jp?B?L2lOekxCVDB2TnZHVSszcXRwbXNSRnlnb0ZGWlh2NTh4a1dvQlkxSTdO?=
 =?iso-2022-jp?B?ZHlzNE1veDhyS2ltMGFSemxCaCtUVUVmc3V5ZEdneVc5Rnh4ZlpmRjlq?=
 =?iso-2022-jp?B?a3JFYkNxbEExdTVZN3hQVTE0UXVPWEVoOTFjalhmMVZqdnlIVlE4RkQy?=
 =?iso-2022-jp?B?THlaVEJRYmNvem1QT3Q0L21qSDV0d3RYdDg2TkRpZVUvYlVrOWZ6MHhj?=
 =?iso-2022-jp?B?aUZkQVZGMXJWK3RrbnlQWkVuM3BYTDJxQzZSVmxXbG42STcyS0d0dlRH?=
 =?iso-2022-jp?B?cnpMK3NoSVNnQnNteFJxVS9jWmJPMjZpWUo2ZG84UEo5djZ4bW4rbFRN?=
 =?iso-2022-jp?B?U3RsbGRoaTNpQVN3SCtxMlc2bFI1dXR0UVdtcWNPMmM3eEJtVTRxMktU?=
 =?iso-2022-jp?B?d1Q3SHFZenVxN2VWczVzU3VJanZmQ2FpZERlM3RQRWVEazU0UDl1eExD?=
 =?iso-2022-jp?B?ejN4bFk3dkZRL1Q5VWxuUWF4SmViNXorSVZBTlZGSzBjM3NFbUVQNGcy?=
 =?iso-2022-jp?B?NnRibkZscnJKYUt1a3NoSHlSTDA5QjdIRkNkUlM3eG1IcEt2ZGRxUVJK?=
 =?iso-2022-jp?B?TTZuSVNPVDhjanlLM3BoSFFCUnlQMU9rZmdmd25Qc2g5V0JLbXUrUklG?=
 =?iso-2022-jp?B?KzA3MldzTDBYMDMyaE5uTGovMTRsenh0U0puNWU4Zm50Mk9PYUJ3MnZS?=
 =?iso-2022-jp?B?TUVhdjNKbkFZd0djZVJMUEUxUnczWmpReHhXSmxHUzNhVHJvSi9QZmt3?=
 =?iso-2022-jp?B?enc1cTNSWnpFYnZVdE9HREs0SlNZUEJ5dUowdTY4c09ZZ0xOdFZCODU1?=
 =?iso-2022-jp?B?UVR3azhnYUJVN1YrQmlFZmNlZlIzc2tmcnIwTjhxd2ZOU3VPZHhlNGw2?=
 =?iso-2022-jp?B?NzN0cDZVMGxWS2RvUDNDSGd4RXZLR0wwbVMyMkpJSHpFTVRnWTNVTnJw?=
 =?iso-2022-jp?B?MDNhU1llUWFWYlBFcjJvb1BTeWgzWnNMT3MvY05rYW1SaXJmOTBzZ2hR?=
 =?iso-2022-jp?B?dlhIamxmVkhJTmt4UENrZTlVWWZZQTExVmF1Y2N3bXlvRmVLSnJTUStu?=
 =?iso-2022-jp?B?V3hLQmxsTmVxaWVSOWRnN2l5OFIxZ285d0U0SHNvMXJMSS94VTZLVkZt?=
 =?iso-2022-jp?B?dVNpQ1ZxTjRXdThIVTEwSjlXSkFxNkxKemdPckM1Z0lybkdZaWdNY01t?=
 =?iso-2022-jp?B?a3V2R2dPMEVCc2Jac3FwdzZKMUwxWk1iQTVETjF4d3VWSlkzY1k0ZEVv?=
 =?iso-2022-jp?B?YmgycVc4VnpvSnA2M2VUV3QrenZWRUk1aWpqQ1YwMWVYWjJKakRlRUtM?=
 =?iso-2022-jp?B?TVN0VzFUQzFTNVp0ZENVR2pmK2xpOWUwcnY1WEkxVUk3eUhWZVJJNmJm?=
 =?iso-2022-jp?B?R1Jka0tGdDRodVNlN296VXNCUlkvQTZadmxlak9mNE9JTFhWNEFGVUN4?=
 =?iso-2022-jp?B?cVFMWURBZGZ0WTVpcjFPVU51WHlld3RJVVJXSjlpK2VrY21jZWtsRGJ4?=
 =?iso-2022-jp?B?MTZTalBqSko2WjlYc1dFcTZyVzcwTXBUNVYrbjY5NmRMSVpwUmpST3d5?=
 =?iso-2022-jp?B?NWRYNzQxaXdZTUQra0FZRTA0VElQRndZakNZWnFyOUcyK3dDN29Dei9U?=
 =?iso-2022-jp?B?bWhFRnRvQnc5My9YK3NNMkd0TnJ6SnJWSVBsK0lhRnYyb1BseDN5UUxB?=
 =?iso-2022-jp?B?ejUvNHdObks2TWhQUkpNMVNmUFR2VkI2Q0dPWisxN3F3ZTNhVzlCUDVx?=
 =?iso-2022-jp?B?VExSekRuV3Avd2JoSE9lZ05pRW8rdHR5MGplWGszdlFOcGJQSWM0b0c2?=
 =?iso-2022-jp?B?QWduWlg4cVNCT2hVQ3greVFQWlUzZmhVVGUydXJudGd3aVZ1Rk5BY3BU?=
 =?iso-2022-jp?B?U3VTLw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D69ILwrZTDDg3ljJpzI1njj6E64psjfmtgZqqWFpHhVnuNGzs4/f+Cf/Bgi8sCRHy8dvXXn2rHRRiSDoB6GXl28UhMB8VxhPGyvLfqKwrHIzDbLqu4Z0e+jBICHrdZSQnIsR+3RkvTCD0Pbq+DXzy5YhwDjI0qEXoDSSJJzVEKYwxDhKdzK3/Mi7SXrCVBKGNB9CrSCkOhhLgu5RYeBIuu1tged+NfM1reF8t329Oy0xbYMHcQRINoTcPitl1vtXcXqtrnhgmYB0ac8xmRe72TG2QyjlnmHNmedEaCBiu7emdnIk2fCadFY2Z42ohxOnelI0rqz4LuTXZh0IObNwFfIa3IE53FoVRSqZq9e6sp2YCDiXLgE5r+6YNONJSFCSyvReJ8gogdj4b+JLcTiECUNhVaMXRwDnR+Xg2tHO5HmZUfzqfxrYM4AXy4TSlCyc//9fZ46mLDqB54O6qKnbJOye+KV+IyulYj6JpC713YbE75UYL6r3OvgslfUMnXPTPHy+F6wUoznKgivv6noV+UHm7dclaT104DAdMFts+j6aNMnIy4H6gmj+xed6NPfvmAJWGN0YtlzM0052PLUVJu6niRLFrnaSfuhkcUG1XfOChhqmoqekF6Jesn/8Kk+o
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB12335.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d3cc37-0fb7-42e9-c9b7-08dcf55ae67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 01:09:54.2100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAZZ3qm+G4pY0wqTm/4yxsUKCxalo650x0+qtT1WjNKRxfKrhEv0RdZZn7cdSg5e6jFmXH469gg1ToyNm8drWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9498

> Yasunori Gotou (Fujitsu) wrote:
> > Hello,
> >
> > I'm trying to execute the cxl zero-labels command for a CXL persistent
> > memory on my QEMU CXL emulation environment, but it fails with the
> following error.
> > ----
> > # cxl zero-labels mem0
> > cxl memdev: action_zero: mem0: has active nvdimm bridge, abort label
> > write cxl memdev: cmd_zero_labels: zeroed 0 mem
> > ----
> >
> > In constrast, ndctl zero-labels seems to work correctly.
> >
> > ----
> > # ndctl zero-labels nmem0
> > zeroed 1 nmem
> > ----
> >
> > Can anyone identify the problem?
>=20
> This is "by design". Once the memdev has been registered with the NVDIMM
> subsystem then the expectation is that label space belongs to the NVDIMM
> side where it can be coordinated with namespace management. The ability t=
o
> write labels from the CXL side is mostly a debug facility, not a provisio=
ning flow.

Okay, I understand.
However, I suppose it might be confusing for beginners.
It would be nice to have a document, like a beginner's guide, that explains=
 which
command to use in each situation.


>=20
> This is also enforced by the cxl_pmem driver where it disables direct
> submission of CXL commands to write the label area since the NVDIMM
> subsystem is in control:
>=20
> cxl_pmem_init():
>         set_bit(CXL_MEM_COMMAND_ID_SET_SHUTDOWN_STATE,
> exclusive_cmds);
>         set_bit(CXL_MEM_COMMAND_ID_SET_LSA, exclusive_cmds);
>=20
> cxl_nvdimm_probe():
>=20
>         set_exclusive_cxl_commands(mds, exclusive_cmds);
> 	...
>         set_bit(NDD_LABELING, &flags);
>         set_bit(NDD_REGISTER_SYNC, &flags);
>         set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
>         set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
>         set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
>         nvdimm =3D __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
>                                  cxl_dimm_attribute_groups, flags,
>                                  cmd_mask, 0, NULL, cxl_nvd->dev_id,
>                                  cxl_security_ops, NULL);

Anyway, thank you for your answer.
----
Yasunori Goto

