Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6186399D0B;
	Tue, 19 May 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184730; cv=fail; b=t7rc2EMHWRwZHdeMrcQke6ukZHlKGt7GI/1W3DULzZmzhcxVCFjbWv+JVSU1ik3uK6kG0vaxI7FPSnfb+E0Bsu4qvxMG2pKsHPpW/kFhZEgSBtBINAIml9KfqPggR1+ieCYYcODyeptHbcUSXI3PTmXGISllUwJ5LYpF3tI6dRM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184730; c=relaxed/simple;
	bh=ThcarFPBVESnZPnuLTYhSl5CS1uh2sl8HYFwq+lc6Vo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xwy7YQdWjvBZ1ckbb3nWiLPQxUi9ge/hZXUOBhiRdI49myeOVhWagna6ZHAf4v7+9dPXF4LZI9limjVYyNRnRcupYlN80UWkQv277n+VbGt22F1+ZH/miI8jJPiGmI+6QxfmPSAlMQL8r4iZzaprGE2Pv7pVl6S8C0g/+AgYQ4k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MvuH6RWH; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MvuH6RWH; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MvuH6RWH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MvuH6RWH"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qMqNCVAkEZIjOQEsaBEOuISOWh6qKqp1MFq4MJZJOppZNiDg56b4HvcYNemvr7cRBmK98UVgeT0LUlOepx5WOrgKkk2NndxBD/wkl3r/Lx/Eh2ojvsUvoYfUIGZc7C+ZeGb2hcBNQZfvhe+v0phauNR+prxESisRcLE8e6hTRH1iOuHpA7d5ppALel7bT7IMz1G1JFyPMCWd/vW+7wqZFBO6k1tfCb/oyP5ATX1V8kFOdCd0hFqaxXTUPI3WKZeDn8VCnO5E+oaQ80OmiDSnn0W4B/YKVV88Ycntg2hSvrSPLK0UA5kGCS/FqxUjR05P7nllqMhQuVNKmtpqJiaKDg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBnmmXvjN1c/A3uRaOsAETJdKVwGJY05qXrqltB59zI=;
 b=jeyAR7hBv30qaW+Bj+dUxDBOLiAj+N7xRIWhtbWASyke1DObxum+1XMzyLYneFL+OrJpIfwZ2ioIziOP+m0Nq2YMqa/qAbB7X2LEwTp9xxJj24cuEVz2OAVvE5fiojFsFfmMUnkdUM/KLVZVLtmOC6JmNtrMx/vyFmtj8d/7Mb+A9WKo27rD5h2U7cWBS07zMkQK7Vpu5NhExR9qQ1HiDQ4cxoaHXQfWuEApCXiS1NbgOazUgG+R3ip9+qHZ4LMqpGt0pbWWTXJIqbsWBMnZpvk0aCowPzLN1ytrRzFGFvBgWErfCxf4xYolqPzTbpDKJce8ZWSajEqPGy3zdxv0Wg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBnmmXvjN1c/A3uRaOsAETJdKVwGJY05qXrqltB59zI=;
 b=MvuH6RWHaZB3+YevKnUNF5ygbkNoZWNiPi9FpR9Lve9j6w7Lbp6G2r3WwSJ8T+H3fx0A5K5fgVUtVhoDLdgQi2BwIw51czOrbK+96IhKPWhgUNEYbxb09OjW/idz9BAZvZWaEEiLjGhkMubRqZS3qx9t8Q/s4spePKO21WToLb8=
Received: from DUZPR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::8) by GV1PR08MB10423.eurprd08.prod.outlook.com
 (2603:10a6:150:165::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 09:58:38 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::1f) by DUZPR01CA0033.outlook.office365.com
 (2603:10a6:10:468::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Tue, 19 May 2026 09:58:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+bcclMDImNeBh+JcSmcree6JMZFjEz2gQP0y2NEVq/T1lKEyFfeqE9BKYjsyzOEkdemrQXzGeqRzY/Mn/9KZa8TQvDNF3GPz2K0oFcE/wyXywmIu5ujBOi0/ecAC8PkhaB/kCpz11XOKkRaf6X6ZiTMyfbyCy/MCT6mDbyGMVdlX6WIzqFS/LOozzJodcPmlnCTrwfzfmndgs+HBQRnUAkAYKssNswSe6va6/DM9o1cRtQVgyoJJ6zFG5nSw1Lp2h5opkY4Dezt3Spk73EjbIY2wpTCqAi+XSCvoVshK3MOna2P39+qgZAs+K9OekSLcGzSCpcqrNtrooiDePDnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBnmmXvjN1c/A3uRaOsAETJdKVwGJY05qXrqltB59zI=;
 b=IZdXOEfjROXuTMt/6wF5u6bmYsVqCdce7RrDePBdnJqAQb+syp4trRZyGegmekvd8mYwMt2vAMKN206ViPImFfG2z9bX3rE0ACc/geVCubCymCWejjU4I9HxfJb6yMEgYs5GTPQ0M33kqjzc+wTf98SGwZmn/HiTqsbi90NMp9KWEePGFQgJfNwyatSScw6Gk11UJupCQ0nNzdaGaW1F6fE7CobOVmw7KwiosYSN5n4mVlqWT26L4tbrbLZ8yPenjslazXoIGiLdYwS8j9jE9TIex/Bz+12C33xEgKi/lIIaiRg/YfcP6YGUQLjXpvhmByiDF3iYW2OOyGTjn/Sndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBnmmXvjN1c/A3uRaOsAETJdKVwGJY05qXrqltB59zI=;
 b=MvuH6RWHaZB3+YevKnUNF5ygbkNoZWNiPi9FpR9Lve9j6w7Lbp6G2r3WwSJ8T+H3fx0A5K5fgVUtVhoDLdgQi2BwIw51czOrbK+96IhKPWhgUNEYbxb09OjW/idz9BAZvZWaEEiLjGhkMubRqZS3qx9t8Q/s4spePKO21WToLb8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by AM8PR08MB6467.eurprd08.prod.outlook.com (2603:10a6:20b:316::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:57:33 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 09:57:32 +0000
Message-ID: <45af60ee-5bf4-4389-a1c2-60bb4061f647@arm.com>
Date: Tue, 19 May 2026 10:57:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] dt-bindings: firmware: add arm,ras-cper
Content-Language: en-GB
To: Krzysztof Kozlowski <krzk@kernel.org>, rafael@kernel.org, bp@alien8.de,
 saket.dumbre@intel.com, will@kernel.org, xueshuai@linux.alibaba.com,
 mchehab@kernel.org, krzk+dt@kernel.org, dave@stgolabs.net,
 conor+dt@kernel.org, vishal.l.verma@intel.com, jic23@kernel.org,
 corbet@lwn.net, guohanjun@huawei.com, dave.jiang@intel.com,
 catalin.marinas@arm.com, lenb@kernel.org, tony.luck@intel.com,
 skhan@linuxfoundation.org, djbw@kernel.org, alison.schofield@intel.com,
 ira.weiny@intel.com, robh@kernel.org
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
 linux-cxl@vger.kernel.org, Michael.Zhao2@arm.com,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
References: <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-0-42698675ba61@arm.com>
 <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-9-42698675ba61@arm.com>
 <5fb43b8d-e772-42af-ba78-d75abd87bd0c@kernel.org>
 <8bc812fd-cda5-485f-98d2-4901ec17c66f@arm.com>
 <d12b5738-ca14-40aa-930f-eddf3199818d@kernel.org>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <d12b5738-ca14-40aa-930f-eddf3199818d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0104.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::15) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|AM8PR08MB6467:EE_|DB5PEPF00014B92:EE_|GV1PR08MB10423:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c34cd9-0b6d-4164-9cd4-08deb58d32eb
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|11063799006|56012099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 KNhrppsg/hFRGyhhYCbZPR/otCrtLYWMWRd4wro75CXvIVz7ztCUfoYGYGixyP2ZiXQsKCWaIPXa2HthV6a5zESWCS7tHrG8B01iA4G2wr6xb1abMhhvfa321MQM995dEhxJLvIqxS2PQpPKsYooFzTZn6QrpP+ZOQMSe7kI/vTguCIgRx46x6qD6Wa5dsJkzOoiej/Yy1Yg+pdVTDffRQwsFoB1r21OXGaCQb13ZceXcHPsnC0ZCFZZID9LyAsoKXtj0L/sirTmXMMLTrROsBJCAGN3ZZHFZnf8fvGJGnUWrmQG8vcDTD6+rQDINqMIQcLa+pT5XhcXiwkLea0g/Ud7Hg0HpD9YGsv9KdXzam+jQ5uEIzNSh7wjzaIuu221XbggL8LrJHzxRAkW711gydsDo2FQ7v3Rn4qvl3L0K1AHqFtxpOIM1gUkjFSIiSIu9OxHXSSE7CeuT9QYe4vHB0GppQj/ZHCJBLoZRhBrnXfdyOlN06OjiOh2vIdP3hn1lksfIXWY1HqVqQr68Je4FMtRiZI6QH+If/X/Qx9AFzpAjk2Wpl/sbf4vjyjboAARhS8I4eF8A7zvVUbrBHp1uaj59bYQoCIZkJRXVwCl0uTDCFE6+f0zl4bz5mXDYVUW6qnfmVD0ZPr8Xk5s6muyfYRFukzran0Xv1Yp/gbZAKPLNfLCovAtnvgisomb1b4gmsbN16oG0GUI14E11SnwB9BkXrcsQGgn00VxXF/9YDo=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(11063799006)(56012099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ALRrrvJZXkAi4YJ9FSTllPEnF4h0DK4SrsgvePKTNqYb85KD7KvAm8eVOoIC3h51bTVpMGhpJnS8WEo4TWv1hlQNOff6iYFm0fBZjBTTwcgy0RNTbDxzVuh6TygU2XHO3hVC22vM+d6HO4JI0MTfrMXNRC9JS6qmlrbhQRbTkqraxAU472ie7rwuuAFkca0lHGL8XciYNA6woN7vlbx9E7lv48lzn5VFmyNvCPqvB86ttxDGknln5e0Y2cLtg0FD1RrbTRDTbtski7rPtuzGnkISBbP+H+IIznJ6nMxG26xjqHVHwmvqaW3bq2gqliYPyVPLlworDFJbi0Dy6kLhbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6467
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	444e3c00-c2da-4b53-a8b8-08deb58d0bc7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|36860700016|82310400026|7416014|376014|921020|11063799006|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	G4snvvgZE+qGjIohZmLiGeAGG30Fjiz3dGsMvtbFC3R5o9YXxkZDovEOJ2eYF/9Qwkmk0EGCXK3JryGH98HCfyTh4JPg9tHbpTLYUDZLJ7uJujt64xdO7zm6Wbzqn1so5uPlZenopS1fPqnXGiyERxm5hqoDgylhY69LYAaagHsweo7spfAOTyG7msIEZOHzm50ML1iZh9uhqUd42gpxoyq9MNpIwBad4+Sgct9DdEEMRXDSPrBghi0OMAi1TrLrWwdcsTsGGQyqwhUGggWvafUJsI5HzsPqokqS22SiqkM/AwEMMCqS9O/efaO74GXNuuRfoZuiMjtPVdUEvO7deiVGnlm1DPLtJ5v67cKFDf3W8X1sVDnkJBHYMRhcgNOl3ef0IUxP+Szbz9sjIQK9nIZPXSvBkqUwt2/E7oxoAiBz83ZMTOdVvGB1tzwGGvewtbLVWDNEcjs5e5bJIiwQS+p49VeqxQGHAMCPZ4iHuc4vN+rbmKW3aDTscFU/qFB1eD5AmhHv3u541SPR+EOsw6QrsGzbn9WdA74brTTqUalTbMCeoehbh4kyWHdHvpKm7EFLwjZiZqFrC0GgrwZ+kWyXEkoa6gdk+YNxzWlufkT7Za8zrsEJfBaB87cgWKqZeTxTznjZqZ8j5lO7AH1jdukzlRbVr2udqjqLZO+/zYw1SlfFGcZj15VLGlcvhY0Ef3evO0x7CxQnUKhFhdGnwY1eRKyOraCYgp5lYeeZm6PRh+ZqgauFbCur7bxE20ZmRJh9j0JWmKNiJdZyB1A0mw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(36860700016)(82310400026)(7416014)(376014)(921020)(11063799006)(22082099003)(56012099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2iQIp9V9P+bJ6BE8ztHIK45UdfAYHy145NPz3XHBzPzel9kZX10vVOokPZlHlsRoI8sF9gNcHXTd0wmggBakVD5JoVzNA8L/H6bbLunBntD8fEQ2ZDE9lN77A/sH0nYAY0zCVCXFO2C+kjkyJp5Ix6syAXbeU4apE8usnA2fGL0XDya3YwBFzRGHkkaw6OwcV77bOdzIe0/FrHAX7mOmuOVl3MyQRYGMHPudiGA0TNHNjr5zfxUPi2MJbk0692lPbZodacf1usTlG/Yj+KmuR63WjHzEoGnj4NIuFcGkpwtlN6I76sFxNaDzmENZPb5Q86LQXcWwOsQ7KBwBRx4xb98VfM1/qHDKFAivSzXfgDjmkoOenC+GDHd6+LbKi5dvTOzV3mE2QmR8q9CgLRHUH9QbGbJIiyjzu0a+wJANcES0p3vzCZZywFOg2DOl8f+B
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:58:38.1527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c34cd9-0b6d-4164-9cd4-08deb58d32eb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10423

On 19/05/2026 10:22, Krzysztof Kozlowski wrote:
> On 19/05/2026 11:02, Ahmed Tiba wrote:
>> On 19/05/2026 08:04, Krzysztof Kozlowski wrote:
>>> On 18/05/2026 13:57, Ahmed Tiba wrote:
>>>> Describe the DeviceTree node that exposes the Arm firmware-first
>>>> CPER provider and hook the file into MAINTAINERS so the
>>>> binding has an owner.
>>>>
>>>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>>>
>>> Please implement previous comments.
>>
>> Could you please clarify which previous DT comments you still see
>> as unaddressed?
>>
>> My understanding was that I had addressed the earlier points on the YAML
>> description formatting, the `memory-region` description text, and the
>> example. If I missed a specific item beyond the one below, please point
>> me to it.
> 
> You do not need other nodes for your device in the example. I asked why
> this is needed for the example, but there was no answer.
Understood. I wanted the example to show the full binding context,
including how the `memory-region` phandles point to the reserved memory,
but I see your point.

I will remove the `reserved-memory` node from the example and simplify 
it to only the `arm,ras-cper` device node.

Best regards,
Ahmed



