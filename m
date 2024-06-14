Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6301A26ADE
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 05:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342328; cv=fail; b=FrCnA9Sr0gj5iqqKL9qLuMBiKZwhxs25sMBTnVC/J/2oD0ofHvigq7tqdeSKt4X9d90zt35f+JBwtny4w21lv9y8W9D/71ErNQ86iqXf0bOZ38e04zr8JuS2LdzSPgs0KrlSXoOa+7rXgD0nKEeZUb5kGtu9D1NqqKBXBFlfoCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342328; c=relaxed/simple;
	bh=GdJ17aVQlq9rE9ZvJqaPTfMg5vmaKvsUaJ4kqDqlqWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jKUtY5DSI+h93UjaQ1Y9zYdt42sDyuPPRpGF4sh44VFtk0m9k+Y1eNTVyilqk56QiT5dh5J0g474DptfxIBC5RTPGN1a9b3VvarAYEBzuWnfZMPhuVapmL+83MZX+VBgK70gsFf25LBm7fb/qPr6uiMmUH+V3gkkj7mLNa78Elw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=EUPtWwTR; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="EUPtWwTR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1718342326; x=1749878326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GdJ17aVQlq9rE9ZvJqaPTfMg5vmaKvsUaJ4kqDqlqWw=;
  b=EUPtWwTRzEOVyGIDXfFPsQOQvGdmYnl687JtU4t6R7KafdFHovp+Ugoa
   jjMZXfj2qD8OqNLIW7AgK5aFyfCd/ttMBvZTtwb1cKem0mqkPH0dUYqWE
   YjQKYy832l0cK3wCyUW8c+3DYAwA0L/oGFBrw+sGT3DbCxg2UbIYKyJcO
   GyRYczmjqvLkB4ne8JtIswax5zrlTtK+VBfn+kX6X1qGqVENJi6SCO3bZ
   WsaTAjXeV9HRIPsoctEB5SrjvmTEELM5//bVLFdUksLrA7mmOUUfR/tPC
   sn+G/fKQr4uRhcpxlL/1WiW/OxHgN7EYXvp50fY7Clhp9aYvY49XBoaoZ
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="122279796"
X-IronPort-AV: E=Sophos;i="6.08,236,1712588400"; 
   d="scan'208";a="122279796"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 14:17:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+XTQI0Tdj9U20Kj4IOlA1d4sUz1SZJVRwGN+oxIqDeewHRRmfTN0igw7PKBuwlK126cw0zc8Zk+JBrfBRjj0DqnOpC7KJPnStgDdS3SuxvwvdMevOH4ubkckwMQRYpiyX79GTteqQqNd8H8y2VZuwn7yeKB7QkkwqnnXnfFS4HS9ZqY/oDnNkGt4+QxasCO1oVeEihv0pBJS9RYn7A7SSBSAbN+3IV6iULPPZlGeG3ZwtaqnJnJrwdtMvzCpB+Rf34AZ9bqU5K6KUjFlqqHvxzNi89eugCDxYb/AhkvqYM9sOhJTszZtKM+jwvIxJksjKyzWlDVVoTVJzvSLZJsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOCs0GzDDvceDuq3/kQ/KyULTp7Ng8YW0x6KhhoXOo0=;
 b=LdT5Nl4gnl0BxDu/S0jydi5NNEbJb3qKNrYMryfgzrVURfTkDUKKro5PDZK2lMtS9+sgCV6BQAoZ7LFXzjk8XF7zYwnAWeODuJkCXmWXdYZeKZ1kykHgo7GtsnCBw62T7AnhHRniZQ756uZQnYMsTE+EsPMV/stHJZwxsq4xcFk32+82FpMmjUJdQMyNlZvg0Z0r6sAq9RJX58G7h7C0XOeOCdKoyWm+Y7cCbY9tyE+LDWxBQ1fg8CQgjq75PKImf0fddWYNtFmi3T9o069xPkhbmd7xz+vpNOqbYyvaP7EF1kjEvc4WYzM54a6bH/oaN5x199kuDBtYoDIj4P8Gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS0PR01MB5892.jpnprd01.prod.outlook.com (2603:1096:604:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 05:17:27 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:17:27 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v8 3/3] cxl_test: fix the 'create region failed' error
Thread-Topic: [PATCH v8 3/3] cxl_test: fix the 'create region failed' error
Thread-Index: AQHavgn7BZqDkBUvbEiAJKa2ZcJHcrHGsqkAgAAFP2A=
Date: Fri, 14 Jun 2024 05:17:26 +0000
Message-ID:
 <OSZPR01MB6453F98066BE28F76684810E8DC22@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240614032133.45365-1-yaoxt.fnst@fujitsu.com>
 <20240614032133.45365-4-yaoxt.fnst@fujitsu.com>
 <ZmvNvqerpvI7IXPb@aschofie-mobl2>
In-Reply-To: <ZmvNvqerpvI7IXPb@aschofie-mobl2>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=10ac9006-6431-47e6-a3a0-e7277f1859e3;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-14T05:16:27Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS0PR01MB5892:EE_
x-ms-office365-filtering-correlation-id: ce74caab-8d2f-4891-050d-08dc8c3147dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230035|1800799019|366011|376009|38070700013|1580799022;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?VlBNWHdCa0plcVRBM0hwdi91L0ZweW4xZ29OcGh2cWRMMUZ5aE9nOWo4?=
 =?iso-2022-jp?B?akJIVGVMdDcxM3FzcFMyQ1NoY1FlQjZpUjFxcHVmSGd2cHVMUFlJd00w?=
 =?iso-2022-jp?B?U1hsRXZRUjlxRzJ0bnhwVFVZTzllbmtLaENsNE9nYnI3N1RoRGxxOU5U?=
 =?iso-2022-jp?B?RTYySzlsazJEaXcvMFh0b3UrZDNhUXFIV1VHK3k4SFRFdlBYL3pJZG5K?=
 =?iso-2022-jp?B?SUt2KzhkOFV6UkJ5Q2dxQ0NoMVFtWTBYNUdKd2syYlRETkttWElJaVFp?=
 =?iso-2022-jp?B?OWJLRFZBSk1lVWtmNmVWTHkxeVZSaVRlOUFJZE9iT1Q2b1pvbUFuQ2lZ?=
 =?iso-2022-jp?B?Zkw1d0RpYm40Y0puQTE0SVdYQmJQdUlnNFdGSFp4b2U2NXJVNVlPMFky?=
 =?iso-2022-jp?B?YVd3R0F0NytJOHBsTHAvb3FMTzNVY2dHNUw1aFpJdXVGZVpNREZJcXFN?=
 =?iso-2022-jp?B?STFMVTZlcklxQUdMRlpuQklYWlpCUWRZL3d6QThMM0ttbzVMQ1psU2M3?=
 =?iso-2022-jp?B?UFRxWnZ6b0NET1E3RFJaZzJHWk5qTk56MkwyM0pxc2dhVmpON0dKR3Jk?=
 =?iso-2022-jp?B?MFJ0ZWNDR2ZLajNkUENBYnpCUkk2OHg1UWlOTHNSaE1SS2RXS3hvRjM5?=
 =?iso-2022-jp?B?WTZKVFovSGh4K3YzejRndm5GZEtnQ0pqV1ZTQVc5aDJHRTgyY0tCNGhT?=
 =?iso-2022-jp?B?VDZLa1lPZkdrckpKdkJuYlh4aC9rNWI3Q3lRR0JObUhkeGhlOVM5ZE1M?=
 =?iso-2022-jp?B?ODU5NndDbEhHcm96TzRnSXNXN3Q3SlNJV0FXY0NwbGhoY01ZNUxVZk9K?=
 =?iso-2022-jp?B?d1pXRXlNOHk4V1dKTmNLaVl4S1d5akp4eG1pbXhUUmg0cVE5ZU1BZVpC?=
 =?iso-2022-jp?B?STRoNW1MWVdoTUY4QWpnSjFGWE9jbnhpTmRKTmpuVHVSWGFwWmJ6eUlN?=
 =?iso-2022-jp?B?cTg4UTA0SUNVM29nVHlMOVlGK21RSStIbGtQYmhNcWdEUWI1SXJub3pD?=
 =?iso-2022-jp?B?M1JTbjBsTzVrRXZ6emR0N3gvRWhPc0d3Tlh6cjVOZ2dIVVJ3WGhNdURk?=
 =?iso-2022-jp?B?SVBCQTQwWVJVSlVvY0liYUZ6QTh4a2lkMVhuR2RLcHZNZFZsdittVzdv?=
 =?iso-2022-jp?B?RmdONlh2RXpiMlk3cklkTUtxUWxCODByc0U0UVJoWCs1a2J4WlVpdU1D?=
 =?iso-2022-jp?B?d1AyRjBCamVWVnJHalQzTlNZWkw1dW1wTFFzMEpEdEtvMjZqZUlzUlpY?=
 =?iso-2022-jp?B?WUxsQkI4ejZQMDBlS1VyTWt3TEJ3RWREZmFTelZqejM3U05JOUoveGxn?=
 =?iso-2022-jp?B?dmFxOWphemk3TXVSOXgvcEdsMUZQSHViNWxRV1FsUnBxV2szTTF3bXNn?=
 =?iso-2022-jp?B?ZFlUd3M2djlTSzJPUTRRQmFRVXV5OVRoSEI5dHp2MFJWd0w3cW5CbWQ4?=
 =?iso-2022-jp?B?UjdIZmxZNXJEaS9lbjNQaCt0OWpmVXFPZjR0akJNZURRbkxKNW5IQ0Nw?=
 =?iso-2022-jp?B?NytxWlB2MkRLTUVzZnR6NlVPdXdYTGptSXN6OUJHSVM3a0RCMkx0d0xz?=
 =?iso-2022-jp?B?WExGNXM2bUswTm9hQW94ZFZFNVVVaUdNRm5OaEo4L2RIWWEvdS84amxX?=
 =?iso-2022-jp?B?Y1dvdmhSL2FvekJETkFkazJ0cjlGcVlLampTNmVlNEkrVEZOZzVSdkVT?=
 =?iso-2022-jp?B?U3c2MlRyZzc5QnFJcjlmVFNJTnpMZ3dERlJtcTlySkZydXlzYUhkTzRy?=
 =?iso-2022-jp?B?Vm51TGxGT3EvZWF4OHNzeHovTGRycFBoZHJ0cUZHbnl4UVlqd2laZVJH?=
 =?iso-2022-jp?B?S0hhQ1ZFWjl4UEVDOW5JandpQUpVazRiaXNsVXk2VCtIQlNBVTl4eHB6?=
 =?iso-2022-jp?B?bFgwbXFBNFU4bkRyeTdBQ1pqY0NIdG1HSmZBbzNmQXpsVEtVb1lDSnVk?=
 =?iso-2022-jp?B?cjdMcUlzUysrcjkxWjNjWFdQT0tUcHZwODJMc0Rwbm9sVG40YmJBSk9a?=
 =?iso-2022-jp?B?UG5CTFlKeGVza0haU0hGb0JTQXhwRWpOY1I2SWNkZ2Nic1FvK2RvUFVt?=
 =?iso-2022-jp?B?VHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013)(1580799022);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MThBRHJYNDRjelQ3Q2dnNGk2WHRGK1FBM05aZEZWby8xWFhXdndNd01N?=
 =?iso-2022-jp?B?UGdDdEZFOXBGVXE4QmNOOHNTNkVQYlpZTG9KZUpiUWZNWi80KzhFbkhl?=
 =?iso-2022-jp?B?dUNNM0VZL3IrVk56aTFRUG9YN0lhdUUrL3haQ1NTdGRldWpOSS9nT1dp?=
 =?iso-2022-jp?B?WE4vTksxMFVmck10L3N4NE90TWIxWlZuTXNNS3h1R0krZEQyNHA5eDFr?=
 =?iso-2022-jp?B?M1B4bzN0STF3ejVsdmZBNjJYVWVBYmlsN1NiSVF6QlRoWjJtY3ZRYjRm?=
 =?iso-2022-jp?B?MklMTUZyVVo3clN4dWxuN21Dclp3TC9Od1FHYTZOVk1TUUpEeDV2TlRG?=
 =?iso-2022-jp?B?aVYzdHIxY2ZGZzJJQU8rSDJDRW5HVzJtRjQvN0prRFlaQVhtS25XMC9x?=
 =?iso-2022-jp?B?VCtRNnRMQ0hqVkRjQzhmQWZ0V2ROU1JXRXlSNTNJOUVnM2szdGdOS2JD?=
 =?iso-2022-jp?B?ZnYvTzRMYlNOZmtPRzgwWnMvTFRGQ0Y1bFVOMzBXK1pIbVhUcEpzbmwy?=
 =?iso-2022-jp?B?Wm5peHRhM2psUStkalQxODF5R0xwUEdSQ1crODhWYkJXa0lBbytWUEpU?=
 =?iso-2022-jp?B?M3JMYnpDaEw4K05uQlNHc09XWFRlajE4RTF0ajdsSlhvLzBaWU1GbzNX?=
 =?iso-2022-jp?B?Z2x0S2pTbTRncFNJdDMzTWtRYkZYeHRndXdYQWI3WFhnbFF6elBYZVZs?=
 =?iso-2022-jp?B?L2N3NkMrd2NPSHVPZHBpbWdpSlIyc09SOEc1Sk83UjRLQ29sbGVhb2N5?=
 =?iso-2022-jp?B?blhTdzhOdXdLdmpuditJVkJFeDRMbkVwNWs2RXIyMm9FTVJGbFpEOEJ1?=
 =?iso-2022-jp?B?cXlTbEN5WXdhNXlpeWd6bWVQNmRWbzYvQ2dBN0ZsUmhrTUVyRXBZODN6?=
 =?iso-2022-jp?B?U2lOY1BJVmdwZG5YaTArTndDcUtRR2tGNm9RQi9QZUhaVklReTA4UGpU?=
 =?iso-2022-jp?B?UGJNeGhDVlNNamlBWmp0bXpVZ0x6QW5SREZlWllmYWpjdjhjNWZ3UE5Z?=
 =?iso-2022-jp?B?TWJxWU95MXVudW1Odm9oZUpNN0NOdmtHT0dCV2wzcDN3LzdCRFkwam1M?=
 =?iso-2022-jp?B?QlRiWlYzRm9PT0dWYWtwTHhGY2N1cHpkVmQ2bVowYW1HMTZuTlN6SFNk?=
 =?iso-2022-jp?B?YktNZ01DRXhhczdFSGkyODVVZitOZ3BaWFVKVklrQTVFZWZpZVJhcnRW?=
 =?iso-2022-jp?B?UDV3ZHgrdHlhWUhqQmFjc1M1NE5qUVZuZXI5QzAyKzdveVhmRThTMjNN?=
 =?iso-2022-jp?B?c1NjV3pHaStXalpSNFZXNk1jMjg5QlFqR2pTQjlLTDhTWkcxTXFEWXpI?=
 =?iso-2022-jp?B?MjVwWUxEM1FNODJyS05zVVpQUjFCYWpyK1JCempzTzR1VkpIN25lcDZn?=
 =?iso-2022-jp?B?VzdWNmZYZ28xa1JuS3JpanE2NWp2Qm4rQXdjTkpYczh5WjQ0UzNZblJk?=
 =?iso-2022-jp?B?TDdMMUphMDNzTW00VlUvQ2tBR2IrdjBYaUNMTzZ4Vkw5UU4xY2tmTDNT?=
 =?iso-2022-jp?B?SUpsLy9YK0RwQ2Z5bFRwdnU2QkpnU1A5dm9oNExlRnJDZDBDalY2Q2tI?=
 =?iso-2022-jp?B?ZEpIWVluVWpuTTBTNzJpM2J3Q25CWHUwY1RIZ0d6SkVsVWJkYXV0WFRi?=
 =?iso-2022-jp?B?YmZxM3ptNy8yLzI2MFcyOVlqOXVORC96UkR4aFNTZDJ1cTN2Q3g2NUds?=
 =?iso-2022-jp?B?VmlCSUF4ckYzdjlVU0FKRExOYUpGRGVwNDJEWWNuMGg5cVdYVCtwV3hy?=
 =?iso-2022-jp?B?d1o1MHp0eU9uQVV6R0dMbmZJTDZrSTRzOTJPSm8vTTNPSE8zM2FrUEJi?=
 =?iso-2022-jp?B?QUptelhuYkhsdkRTT2s1RzJmd2J3bDZIVEhhSU83cUJlWmk2bDVGSElI?=
 =?iso-2022-jp?B?ai96Q0JUN1l5RU9zWVdqYVRGWW4vK1BPOGdNRlBNSWt6YlBYS2JIWVp2?=
 =?iso-2022-jp?B?V3hEQ0VlOWxvSjBEQnQxd0tUalVFYm9KYnlpaHpqK25JRUwrS3ZCYmhr?=
 =?iso-2022-jp?B?S24xYlZ2TGlOeUhOc2RrMTlRcmMzNDNJQUd4VjAzRllsS0szS3NpeU1k?=
 =?iso-2022-jp?B?U1VQclpURkRUa0Y2QXRyaXVkWDlNSU1MZGVveGRJMHNRRW1DdFhEVm5z?=
 =?iso-2022-jp?B?Y2MxZ3g1NGRIZGNMU3VxMk9yMkk1Qmx2Z21DYkorVnlJMVc4STBld241?=
 =?iso-2022-jp?B?MmVYT1ZmR0VibHZkLy95bWc0RmphR2NMV0IxZ2MyeENPOWMyZmIwdVJU?=
 =?iso-2022-jp?B?V05TV3ZhOTZvRm9UbG1KTUFiSVFwVzhJY1hCcUhOU01zY2djb1lvQ01L?=
 =?iso-2022-jp?B?WG5ydQ==?=
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
	Wf/d50E5vGLeOEENtKY8H5vEeL8M3DOgHFqqrouI22QZLj7VnO/hnLGUpel4Rd/jIwkcqK/Jjgne4+GOdzxEt5oEeZkBD3bq3XLjnKbb4YN9x0dyRIz8rgdVvlFcsfJ2TmLuDaYZ3B/FrjEUZm4nFeihdsINb89D0EJ7XQleimdDos6mRarHBypfJQ3w6Je3e162tfZyxb/2V1UeVawkt9IZ6YRewv2Yk4Hrli/QlXjiTWidx4CS3XbpfNToYmA3NZZIHFrZKxMH6ctDa62YiPC5OoBDxwZ24Ips3EdqkmHgGjmUNmY60sX5Ls80CQtVRIaf9eAoJm+4mIfko43iq71Z3RnX60WNOn1P+uZ0I5j5DRVyzcBhcobrO348qgI72VTyqbg1hlveH+OH/ZHrLtfv44Q7laHjDIGoN4tqjZTEkuGFXzZaA5DdwLRmz4nF554V8aL92C4NDUp48wbuPn+RYqHDphrMlsh/PqmmYi8gB2ms8QDVIK1Hy2VPT7c0dtGadT6861Iupm+0KLnjG3AVa9ld3TERckv6B9yVKiW7v2ePJgor3MLxGYTBHf1QBK/tBbiAbGt587CJAhJyEQIYdc6/13YCD8hFlAp7Rah5Xe7blB/GX56jRXI8UsSj
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce74caab-8d2f-4891-050d-08dc8c3147dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:17:26.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNjwAo9dSw3eq1Yzy5zf4FOZv1IQkun4YzB+VZhR+FxqiGygfpc6tbdl+eEQwhfpxhnYABbdV6Cb1CZmM30N7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5892



> -----Original Message-----
> From: Alison Schofield <alison.schofield@intel.com>
> Sent: Friday, June 14, 2024 12:58 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: dave@stgolabs.net; jonathan.cameron@huawei.com; dave.jiang@intel.com;
> vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com;
> jim.harris@samsung.com; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH v8 3/3] cxl_test: fix the 'create region failed' erro=
r
>=20
> On Thu, Jun 13, 2024 at 11:21:33PM -0400, Yao Xingtao wrote:
> > Since the interleave capability check is supported, the cxl_test will
> > fail.
> > Support any and all possibilities for the mock cxl device (host bridge,
> > switch, cxl_mem .etc).
>=20
> This needs to be folded into Patch 1.
>=20
> FYI - sometimes when we add a new feature the cxl-test mock support is
> added as a separate patch. In this case, we're just preserving existing
> functionality of cxl-test. Prefer not to break it in Patch 1 and then
> fix it in a subsequent patch.
OK, thanks for your advice, will fix in next revision.

>=20
> -- Alison
>=20
> >
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > ---
> >  tools/testing/cxl/test/cxl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.=
c
> > index 61c69297e797..fbebcda4364c 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -630,11 +630,15 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct
> cxl_port *port,
> >  					  struct cxl_endpoint_dvsec_info *info)
> >  {
> >  	struct cxl_hdm *cxlhdm =3D devm_kzalloc(&port->dev, sizeof(*cxlhdm),
> GFP_KERNEL);
> > +	struct device *dev =3D &port->dev;
> >
> >  	if (!cxlhdm)
> >  		return ERR_PTR(-ENOMEM);
> >
> >  	cxlhdm->port =3D port;
> > +	cxlhdm->interleave_mask =3D ~0U;
> > +	cxlhdm->iw_cap_mask =3D ~0UL;
> > +	dev_set_drvdata(dev, cxlhdm);
> >  	return cxlhdm;
> >  }
> >
> > --
> > 2.37.3
> >
> >
