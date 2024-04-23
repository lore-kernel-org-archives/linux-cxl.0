Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970EF1095B
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713840537; cv=fail; b=LUmZB89i7G7PL0V5vUZ5p2XCh3nlIU2LNV4MRdnCXYYWXvR4BpDhY0h2liys1Wk5XTp14OT3MMixZly8NxIPBmtnZ11+9qlU4m8ZunVaJd1glbPmr6eOpq7YQtDOhrp0q7PmAyFOvmL+2QD2tX33+7Wv2S1/TtwK9sdLBZ5SBgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713840537; c=relaxed/simple;
	bh=ebmPl2gxYW/XuVQag/t6KUnsv6CRmDS0GIIQBJYO0Yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h/1CKVEJxwpZY1Xk7jcFBs1qzPqwHorEt9Wk4GF3Dd6pn7X1EbStwtRhHGIBe2htO0y1AkGXsQof6h6uZUdV2nR5k2bsLzzDjaQd/0H+E74UjIOkCsdBhmf3v4QSa78rYO6wWTq2+m+KmitCoFSuOuzpZWdeI7NLzkayZ0FXYTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ElMzl7Rd; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ElMzl7Rd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1713840534; x=1745376534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ebmPl2gxYW/XuVQag/t6KUnsv6CRmDS0GIIQBJYO0Yo=;
  b=ElMzl7Rd9KTeY50bdjDX7u90bVs45mKfFKvv+0npBGH52y83SphMMRuB
   lX4OAcPPKnzcLWUnRnn2L+y71WRtNJqOX6A8HSY11zEuE5FyDruFlc9YL
   zZ8hgTLvP/TcDgUKc01ovRvHTYj0NnkfvHaNNtkDHWxUeVhapM5HSp9Lw
   u6dJRMN+xumsmvjg3YzvUISvWtfl9QghBpOTBjHXEue0rIrWPFd+gebjU
   LjLhAN9QpAlyM8i+wcNPAB5P8mzoadAYY2ueEe6/UXRXq1wvFWw/bU7pC
   Z5xlNqLiD9Wy/PdJsZ40EIvRjXXKZ9IGUCXOXYOtnJG6WMpj+/zaT7Bcn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="117593292"
X-IronPort-AV: E=Sophos;i="6.07,222,1708354800"; 
   d="scan'208";a="117593292"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:47:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3iIl32YmlbIRTujYN+2UJKVa1SOP5sc1uO9yaS9koE+nN9LCqo0aFKuYohQoRA3PvZjb8rZRy6vfEwMpbR2sl5p26s9Zf1pSOGMeUVBDzzpuJVOHkRKnK69noApze/r/7mx2r1wz1Fp/0pPmjuMZZxLah6gJOnDQMobMH6MEdPY4zO7UtRB60htYSSKUzv8JJHt7xyKhg7xpNhHHnfL/5zLnY5qHwvZcxMVKn+8qYDIG9PY1bHtZfs1b/UNR21D7pJP5UahNlNlMVrRywpp5JfGxenY/drXFaQYP9ogI7oIpgwvj9b1UVygnY4Z/4HnPO4zRcvuHdpCp0/QUMyNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK9obWZOjd34+gcNmE4oPlNp9EBg24m+7tf1feureRY=;
 b=m991f0EIQ9DdPOmVxAlteeEFrzDJ7Een9sQ4N/9nbg2QxTPk9OYM5o/JXSUPpJk3VWSC/xyTzXRfCHRlVgc5sfOdUZTsUHzJ9Cwm+as8XW9y2KeFs8TxJQBh6oGMvEsStZwR80s3ipez+lEJrEquq3cMXIayiQDXHCsHue1d1gWJmnkl3vFZILZmfagZ0dEVtWfzba97AdxEdGg+M1dUQTmHQoJgjiR/RyHa+Y8te5BiOstLGjge22X/xw4a1+4xJNlHAx6l2rO4Lq6aYb/lckkzJvdR4rXcPkZmOb89Dlz8fZyp7qoSY9F1oIuMLk3TsBFSijqMhRBQ3NdXBwmnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB10008.jpnprd01.prod.outlook.com (2603:1096:604:1df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 02:47:36 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 02:47:36 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "jim.harris@samsung.com" <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] cxl/region: check interleave capability
Thread-Topic: [PATCH v4 2/2] cxl/region: check interleave capability
Thread-Index: AQHalJWFMLLcyIwdlk22sjCGWvAyarF1CckAgAAXcpA=
Date: Tue, 23 Apr 2024 02:47:35 +0000
Message-ID:
 <OSZPR01MB64533E9B5F137904A2CBA83E8D112@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
 <20240422091350.4701-3-yaoxt.fnst@fujitsu.com>
 <662707ea3fb4_6910294cf@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <662707ea3fb4_6910294cf@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=70c57eb2-3073-4238-87ac-98501815e0e9;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-23T02:23:22Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB10008:EE_
x-ms-office365-filtering-correlation-id: e0acab0f-5530-4bd7-5242-08dc633fbb06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZTVsVElYTWRUQ3NmT25RYTdtUDNpbm1GSUJWeXZKNGdIS2JJeEh5RCtQ?=
 =?iso-2022-jp?B?c2ltbDViTTl1d0hoS2p5YW1pMFJlbU1WNFhQNi9hb3psczgwTkFQWlIy?=
 =?iso-2022-jp?B?Y1JrV21rYWxFeUtNVnpXbllTNFVjcmx0M0JwVW4wSXZIaVBhUVRkRzA1?=
 =?iso-2022-jp?B?QVkxQUFkY3YrN2NJS0lZdFRITGdGaCsxTHE4MVBxSytpNUxvUXk1MVN3?=
 =?iso-2022-jp?B?ZlVnblZXMTJ5a1RWQy9sWUo0TFhpdWsrelNZdHdmaUlOMUZXbzJjRElj?=
 =?iso-2022-jp?B?QlJTemNBSnNDUW5iTG02OEtWak9MMEVtNFF2cTJoYURwaWl0bDB2UFVu?=
 =?iso-2022-jp?B?ZUhEdkRMR3d0dURQek9WTlVxTTVJQTNkaEZ6TlpmdDRSTVhETzdQMzhh?=
 =?iso-2022-jp?B?VFQ4NUY0RFFjRm9nakJJbDIyQkhmSnNQSzFhdFBIQUJWZVZ5UVR2OUNn?=
 =?iso-2022-jp?B?TUYrZWQwSHpkWEdPdURhcjFBMCtWd3V4bGdIUGwxbW5PZngwY29rT24r?=
 =?iso-2022-jp?B?clJSQUwvTGdDK29NSjFLdFh5VXRWNGd3bWdpWUQ3cHZKZUZIY2V2UzEy?=
 =?iso-2022-jp?B?d0xzUmRRMzZIdmxFR2N2WW0zUE9LTUZZelJsdSt2K21NTTdPQlBBZ0dQ?=
 =?iso-2022-jp?B?eVhYNGRQTXBhY3RPMXpCWHQ5SWVxRDB4bjM1NTcrRmF0c2JQalROazd2?=
 =?iso-2022-jp?B?cnRpUVlDSHdtMHhGUWlzRGo2TE1leXlGNlJiZjVvWGJtSWsyS2JGYlFw?=
 =?iso-2022-jp?B?UmFFTFNMVlN4Qi9wUC8yckRWcVUwZXBvc3RYdERDQzBiRUpJc2pFMXpy?=
 =?iso-2022-jp?B?ckVCRzVGTlR4NnAxdTh1d2YvMXhTQ29ITS9hWXNQc0pHYUp0VlpJVU9E?=
 =?iso-2022-jp?B?L3hZQzBOMXBWdFlEZHpWTUVOZm5adHI0ZGxLc1NVQVY2UGp0a1BWUE1M?=
 =?iso-2022-jp?B?UkE3ZXB2WlFWRHlQM1g1UUZGRkZhYmFvSndMdFB0QUN0T1VSR0tuNmxR?=
 =?iso-2022-jp?B?S2dQMXdYVWp5NWNBdS8xNGFOL0pwcTg4ZitkaHEyOGl6ZERxdElNZkJm?=
 =?iso-2022-jp?B?Qy9CUTFGenFlelFjUmZHcWpaRFdUU2JRRk9JWHhlL05RZ3dhdkRxOWVr?=
 =?iso-2022-jp?B?a3BCSDkxbGxKMUg5eDQ5cXN2MXlWSnFXbkZNVUpzdTVZUUx2b0FHMnI3?=
 =?iso-2022-jp?B?cDUxdGR4Yzdjb3h5NTZFYkpNOE9tRjJIemNLTmRlZkRXTlZjaFFZSmR1?=
 =?iso-2022-jp?B?cnZHNGhaNEVqRzBGakpzNjhQR0dBbEM2QzJ5TmZpbWwwTWV5Q0V6VUUz?=
 =?iso-2022-jp?B?ZTF3a2dGczVRV25iZXBaNXQxWlI5R2dIMi80NUU0cEl5WGZCMmpuZEtV?=
 =?iso-2022-jp?B?ZG5LeFB4a1FWRjBqNXRweVVSR25hTDlDZVJ3eGNwOERtT2R4aHpEWkVM?=
 =?iso-2022-jp?B?YmhhS3hWQlY5UEZBZmFPM1EvZWdvYk5TNnl0M2dPZDJkd3BEV0JIZXdr?=
 =?iso-2022-jp?B?WkQyZGc2RElFSittL21Qd1I0UkxJdmR6cDhtUlFJS0NyV3F3ZWxHd2p0?=
 =?iso-2022-jp?B?VjlGRk1nRXF2WWI5N3IveC9zaldkc09SQlFHcXVWNnlPUmpBeDFxc0du?=
 =?iso-2022-jp?B?RU10MkRFWnVMNzJFV1VpSHc1QXlpZUhZb04zNmszdDIvL3pURFg1OUV6?=
 =?iso-2022-jp?B?ZGl2NlFWZkVYSWsrRytIRkduL08wMUU3YnZ2Ym9YWURYc3NMdHlUeEhU?=
 =?iso-2022-jp?B?ZDVDd0N1eDJPdXNKVVRhb3NtVWdVdTM4bXdXSEtiaXFaeUh6SDV2VVVv?=
 =?iso-2022-jp?B?aFVLM24yT3JTM0NLMmVXcURtL2d6QTZSaG9pUllMQkhuV0laUEd0Vzkw?=
 =?iso-2022-jp?B?ZSsxZjg3dytCcU1ML05ZVGRLQlBMWVhiaEhnekx0RmRad3p0MDBWYmhR?=
 =?iso-2022-jp?B?ZUtRNVphZDNCMTJJWWJxbjZXY09qcEc3UmhvQ3NHRWdFNXZlSkN2bW1T?=
 =?iso-2022-jp?B?UT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Zjl6UE9DUXRWOFM4ZkVDV0paMjAwWUVFNlhObkFNK1ptREM3U1hqWFU4?=
 =?iso-2022-jp?B?R0J2L2ZYSXpsekx1Q0RyNmt3czJDZ1pMMktSLzVQSkVJbnJkaEtaS1c3?=
 =?iso-2022-jp?B?MUlRZ0JuMjQyRmZJamxZQ1FzaFVkUmRCUlNxSWFQc0Y2dzUzWnVaUXMz?=
 =?iso-2022-jp?B?dXY0aHNEMGJNT2JsQ3I3SEdWYk5aV0FiM0hURTlIL0xScWJNd3JJNUd1?=
 =?iso-2022-jp?B?cWo2bjVOQlV1Z0NBRDFlL0lTY3p1UHc4cjVzOWNmTHV2aGNvS2RPTTl0?=
 =?iso-2022-jp?B?RHNPUjkyR1JSNGMvNG45L2RRSllTb3NHdUdUNWpFNWRKeUpSeXJuWVZ5?=
 =?iso-2022-jp?B?WlMzd09FUVUyeEh6ejFua21DNFZZQjE5MlpacEJQWEowVnVEMHN4NTF6?=
 =?iso-2022-jp?B?dTVTcFB4QnJSNS9lRzFodjlBb3k4ckhrKzRSemxMam5SNVVHYUZkOE9p?=
 =?iso-2022-jp?B?RURKcnpsS2VObXVqb3BSTnJhUUtwSTc1Nm91UlYvT0RsSFUycUMrVDh3?=
 =?iso-2022-jp?B?ODFGSkEzbmlFbldrbEVuWmJXdHhHbmpPdzErWjZPOWlHbGVVWUVnSmZY?=
 =?iso-2022-jp?B?ZW1rSDljWXg0bXJ6N0RLMzk0aEF4a3k0NkI0Qi9NdmJyQjZOYzB1RzYz?=
 =?iso-2022-jp?B?UGlBV3ZsZ2xaYWdSdVZUZTB2czU1eWtyV3k2VGZabi9yOE5ZNE5MdEJQ?=
 =?iso-2022-jp?B?dFlXdUdjWUVlS3NQeGxZN21XT0ZrQmtJR2F3aGhJTEwxbWlvSXU2SGdw?=
 =?iso-2022-jp?B?MXNGNGRlQVJEdjM5RXUvaW9aaWoxMUlTbVI1UlN2S2JpK1QrYzF5NnJO?=
 =?iso-2022-jp?B?L25oZC9OUldPNWlvK2ZYa2plNk1obzJKdi9zd0VXTzYrTHNMNVErRjY2?=
 =?iso-2022-jp?B?dzhSZkt6Y200M01nTE5RYS9udEF6MDF3a081RVpISDVLWmhJUkRIWTJt?=
 =?iso-2022-jp?B?Skk1bGM0b2VOUnNybWt6T3hWcmF6UGd6eFN3aWc3NW1teVdUSEwrdDZR?=
 =?iso-2022-jp?B?b0l5bXpFMnpMdzl4RlEzS2huWGhNeVpXUWNvR2VyVEx1czRCeGlrbE1s?=
 =?iso-2022-jp?B?OVpGWUd1YUt0NUhJYmZCR3dUdHJDQU41RitjZU9sSllQaU1uWXhnazdP?=
 =?iso-2022-jp?B?V0JLeGFML2JRQ3hSTUNndVdERExBOENoOTJwV3BlTkV3cUJUaENUWmQz?=
 =?iso-2022-jp?B?QzZLUUNJNm9jbUUwdlFBam00QXlnZmNkWGxzSzIyWERVSkxnc0t0NEFF?=
 =?iso-2022-jp?B?UlFzZjFOZkFCbjU0RXQ1VElCdFZGQkhFODd5Qnd0OFhwcjUxNHFRWWQy?=
 =?iso-2022-jp?B?eWtWODROUDgzenBrRUZ3Tk8vVkVwQm45dndTZDVXam56cGF1SXRXeFk2?=
 =?iso-2022-jp?B?WnBYc2N2VExGY21DQkFZSk1YbXhiQ1JtNTNoWVNLd1l1MW9mcU1HdmxJ?=
 =?iso-2022-jp?B?aThVbFgwQi94UVdZYVMvYmhKczYyWjdFNWtmWlB5NGwvMEVaTFhXYmp2?=
 =?iso-2022-jp?B?N2dvb1lSRHFLRGFmL3VJQzV0Y2doYTNUNGl6NEIzWTVKeUtQaUhRS2VJ?=
 =?iso-2022-jp?B?cVFjUkFBcXhOTVJPYUtQRFJMbHg3Qk1Nd2NwUWlwY3hqMUVETkxJWGRX?=
 =?iso-2022-jp?B?azRyN1hjTC9jaHVmbXYwYmNQMW9rVUhzQ0lycTBKNFlQeVJEZGVFL21U?=
 =?iso-2022-jp?B?TFB2RXRqNVhCZTRTKzJsMG5hZytyVmhVN3ZpL2hIc2JWcWhNMkFYRDd5?=
 =?iso-2022-jp?B?WGR3Y2xxa3hhUTdHTnJjL2U4NFU1ZkRFVnMzUUNnMVo1cGdZRDh4bFE1?=
 =?iso-2022-jp?B?SUl2WkF2SWw0MC94VUhTMG83Ui9UckdTNWJvak1rV2x3R2tmdjU4alFI?=
 =?iso-2022-jp?B?Ny90SldCWFlycVB2QlRuTThpenV1RklPcm9Td0F2K3N6UFM3TUhCUGw0?=
 =?iso-2022-jp?B?ZlVtUTNlZ3dtQlFxYldIL2VraW5mc0wwTmtZb3Btd1N5NEVqc1UwLzBo?=
 =?iso-2022-jp?B?cVdmMFEvNFMyaXNockliaDNyRUxtYW1MYWxsL3lpbTUwTllBQTRZMHdU?=
 =?iso-2022-jp?B?ajFCU1N6VzVXclBySnZKVEZ6OExFdk0zN3ZWTVphdWg0NDJFMXhqV3BE?=
 =?iso-2022-jp?B?Um5McHQ1a21rR0hsNG0zT1BjbUNXSk1jSEZBNUJEbDhXSGJ4cW45VmRp?=
 =?iso-2022-jp?B?MjB2eW41Slh2SWVnUWwxQThVR3M4cE5IakMwRVFGalZCZE10YktZWms5?=
 =?iso-2022-jp?B?TVcvQkptdjlzY2NhWm1DS0VtVzZ3LzgxaEJkdHRGY3RnejJhRGczeEU2?=
 =?iso-2022-jp?B?NGZ4eA==?=
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
	PdKb0ePugqprvGULE9MtjU8wpvY47+ltjW1hBqitwIclyg3b3PvZQ1flup2bELdYEVxOy+sM8roWqyDtvDS44XUbWGQCU0FoFhzaFbS0tTVUqOI4CCkNQBdnyRoTsHscPldnpPpz/RCcLMdqlUqWZGa6kZzQmFW/FeyHzKWpGOwyZUXYE3uKwAhie8a64+n08JRn6Q1b3ZjR2BUEcROui42TxejP3of+OMyPuXqic61I+CDOGdk2SSu5hwvJtrBHr0NKUrGecm+kSlAuVwVqIFdzABe8PcLNVWQLdOvENiszIgti4kulUD2j6G9hWFnuOID221py/mI+oD9zeNuY9jfb7zoYcYTCNehczOk3MIJRixgdv9u/C3TpRwGU3rEL4u15BHvlrtDTevoA6PNykFbu4wLEZnSLTHNc09ltUq60IUSkjFGokESpOUHPBCDMkONjHNJLVb47JyhEIFiM64iH6s8vPOFEZAsWxpUot/WLRPAAvvYW/v9UorO5EtelVG4bDEzkxAJWib2WrWLqGy9y5CMhyrDoVPfrGjeF4J/p94avIHXRhTnQlHUISI7UqD7+NURkm6VmOv9zdUorl01a/lqPIIPAgCwb75/fXzegN2PwXkNg7CeELaaSMhTS
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0acab0f-5530-4bd7-5242-08dc633fbb06
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 02:47:35.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PafctQzQzBMqKFBQG5GmKIxcu++Zx2AZBWy+xZ/yLeZ1HS/myFWQSq+5DPPv6Jj5p7+I6KlqUSXouNzQPpV3sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10008



> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Tuesday, April 23, 2024 8:59 AM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>; da=
ve@stgolabs.net;
> jonathan.cameron@huawei.com; dave.jiang@intel.com;
> alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com=
;
> dan.j.williams@intel.com; jim.harris@samsung.com
> Cc: linux-cxl@vger.kernel.org; Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <=
yaoxt.fnst@fujitsu.com>
> Subject: RE: [PATCH v4 2/2] cxl/region: check interleave capability
>=20
> Yao Xingtao wrote:
> > Since interleave capability is not verified, a target can successfully
> > attach to a region even if it lacks support for the specified interleav=
e
> > ways or granularity.
> >
> > When attempting to access memory, unexpected behavior occurs due to the
> > incorrect conversion of HPA to a faulty DPA, leading to a segmentation
> > fault, as observed when executing the command:
> > $ numactl -m 2 ls
>=20
> This is a QEMU specific statement, right?
>=20
> That should be called out, because I suspect the behavior on hardware to
> be different.
OK, got it.

>=20
> > According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
> > Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
> > Capability Register' indicate the capability to establish interleaving
> > in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
> > be attached to a region utilizing such interleave ways.
> >
> > Additionally, bits 8 and 9 in the same register represent the capabilit=
y
> > of the bits used for interleaving in the address, commonly referred to =
as
> > the interleave mask.
>=20
> Perhaps replace "commonly referred to as" with "Linux tracks this in the
> cxl_port interleave_mask"
looks good!
>=20
> > Regarding 'Decoder Protection':
> > If IW is less than 8 (for interleave ways of 1, 2, 4, 8, 16), the
> > interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1=
.
> >
> > If the IW is greater than or equal to 8 (for interleave ways of 3, 6, 1=
2),
> > the interleave bits start at bit position IG + 8 and end at IG + IW - 1=
.
> >
> > If the interleave mask is insufficient to cover the required interleave
> > bits, the target cannot be attached to the region.
> >
> > The above check does not apply to the host-bridges with single port and
> > switches with single dport, because there does not have a instance of
> > CXL HDM Decoder Capability Structure for them.
> >
> > Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > ---
> >  drivers/cxl/core/hdm.c    |  5 +++
> >  drivers/cxl/core/region.c | 70
> +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h         |  2 ++
> >  drivers/cxl/cxlmem.h      |  1 +
> >  4 files changed, 78 insertions(+)
> >
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 27fb4f9d489e..b201be4b8d76 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -80,6 +80,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm
> *cxlhdm)
> >  		cxlhdm->interleave_mask |=3D GENMASK(11, 8);
> >  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
> >  		cxlhdm->interleave_mask |=3D GENMASK(14, 12);
> > +	cxlhdm->iw_cap_mask =3D BIT(1) | BIT(2) | BIT(4) | BIT(8);
> > +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY,
> hdm_cap))
> > +		cxlhdm->iw_cap_mask |=3D BIT(3) | BIT(6) | BIT(12);
> > +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> > +		cxlhdm->iw_cap_mask |=3D BIT(16);
> >  }
> >
> >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *in=
fo)
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5c186e0a39b9..5c09652136c9 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1210,6 +1210,60 @@ static int check_last_peer(struct
> cxl_endpoint_decoder *cxled,
> >  	return 0;
> >  }
> >
> > +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int =
ig)
> > +{
> > +	struct cxl_port *port =3D to_cxl_port(cxld->dev.parent);
> > +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
> > +	struct cxl_switch_decoder *cxlsd;
> > +	unsigned int interleave_mask;
> > +	u8 eiw;
> > +	u16 eig;
> > +	int rc, high_pos, low_pos;
> > +
> > +	if (is_switch_decoder(&cxld->dev)) {
> > +		cxlsd =3D to_cxl_switch_decoder(&cxld->dev);
> > +		if (cxlsd->passthrough)
> > +			return 0;
> > +	}
> > +
> > +	rc =3D ways_to_eiw(iw, &eiw);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (!(cxlhdm->iw_cap_mask & BIT(iw)))
>=20
> Would be nice to just write this as:
>=20
>    if (!test_bit(iw, &cxlhdm->iw_cap_mask))
>=20
> ...requires making iw_cap_mask an 'unsigned long', but that's worth it
> to me.
>=20
> > +		return -EOPNOTSUPP;
>=20
> This should be -ENXIO like all the other hardware mismatch /
> misconfiguration errors in cxl_region_attach().
OK, got it.
>=20
> > +
> > +	rc =3D granularity_to_eig(ig, &eig);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/*
> > +	 * Per CXL specification (8.2.3.20.13 Decoder Protection in r3.1)
> > +	 * if IW < 8, the interleave bits start at bit position IG + 8, and
> > +	 * end at IG + IW + 8 - 1.
> > +	 * if IW >=3D 8, the interleave bits start at bit position IG + 8, an=
d
> > +	 * end at IG + IW - 1.
> > +	 */
> > +	if (eiw >=3D 8)
> > +		high_pos =3D eiw + eig - 1;
> > +	else
> > +		high_pos =3D eiw + eig + 7;
> > +	low_pos =3D eig + 8;
> > +	/*
> > +	 * when the IW is 0 or 8 (interlave way is 1 or 3), the low_pos is
> > +	 * larger than high_pos, since the target is in the target list of a
> > +	 * passthrough decoder, the following check is ignored.
> > +	 */
> > +	if (low_pos > high_pos)
> > +		return 0;
> > +
> > +	interleave_mask =3D GENMASK(high_pos, low_pos);
> > +	if (interleave_mask & ~cxlhdm->interleave_mask)
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_port_setup_targets(struct cxl_port *port,
> >  				  struct cxl_region *cxlr,
> >  				  struct cxl_endpoint_decoder *cxled)
> > @@ -1360,6 +1414,14 @@ static int cxl_port_setup_targets(struct cxl_por=
t *port,
> >  			return -ENXIO;
> >  		}
> >  	} else {
> > +		rc =3D check_interleave_cap(cxld, iw, ig);
>=20
> This seems too late to be doing the check. check_interleave_cap() only
> needs to operate on all the 'struct cxl_port' instances between the
> endpoint and the root. That check can be done be walking ports at
> cxl_region_attach() time, no need to wait until switch decoders are
> being allocated.

I think we could not get the info of iw and ig for switch decoders while wa=
lking ports from
endpoint to root, they were set only in cxl_port_setup_targets().

Is the above understanding correct? if so, the interleave capability check =
cannot be performed=20
at the timing you specified.=20


