Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021117.outbound.protection.outlook.com [40.93.194.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605DC61FCE;
	Sun, 28 Jun 2026 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782662426; cv=fail; b=OlNvFLAXJUnWlrmOXUyiGP2QLEwSzGq9FC3opPq5/fydjVOJ/BVgKoIv+7suwQSH6PmNJIgIDFpeotfhmvk1b9R8Lv/xISGxozgW76p0LizeNwwTFa+i+DqFNRMvl7at0htJZXTz5KbSmB30t/VgEC72fdqW8bEaSCGvos94eNY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782662426; c=relaxed/simple;
	bh=GCDqNLVwSBZ3jjtJFOzZBjYJwzXVFoKn14rAcnERhTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQpArHQbkzZCra3BKC6r5tSSTumHN7eKF+DEwcn4oboMyZo8BFf7Wa+ZyQ1Zxo8qCsRsfN/OMUjg3RdDxlnYKo5hZ5v7XM7wvKYVGgmbBaoMFWD4/QhWJEEsVk/cdUsjUy0/MaDJTPmfMzq4wAkURrA7LGw4xfzygR2OWSlCyEY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scaleflux.com; spf=pass smtp.mailfrom=scaleflux.com; dkim=pass (1024-bit key) header.d=scaleflux.com header.i=@scaleflux.com header.b=UNbklsRp; dkim=pass (1024-bit key) header.d=scaleflux.com header.i=@scaleflux.com header.b=UNbklsRp; arc=fail smtp.client-ip=40.93.194.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scaleflux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scaleflux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=scaleflux.com header.i=@scaleflux.com header.b="UNbklsRp";
	dkim=pass (1024-bit key) header.d=scaleflux.com header.i=@scaleflux.com header.b="UNbklsRp"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TdwPONvgB1kR1HL4TjVRdu6PaCUBQ5V1xGuF1hZxcrqTF9w3mMxHEJtWLtKlMloxH3BMduu20ItxMF8FfOdfzs0MgTd9zZRxb1EjzHJWPC4p7TDL2wMg2RrwgwhE12T+iCU+tQ8WdNb38sGXiW6bd48qiKGpoLHAiD4ZVPUtguot+SE979sQnwoy4LT7YmS4IbTTmmx6xG5L+BzTkiHavvDw9soPy3o/4jXd0dXGMD47iAUGp521YQPH3ld4FBNt8p2beJ4xv2HtI1GgOkVypi/ivSFWTkdk7OYuwTHT6g96tB9Jcp1X1jv7udqhmZNQmRGyOVp3u9Uv/Vh86r+UzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfDvV4d4viS25J/nwxWBysu3meKA1qxkMV9SPQBVogY=;
 b=ic+9mFovwcBUxVXlF9Ee5c6LquhfehqhSjUFqpFtT/kSeYpusUchi6FliGrYyPJ1fQSvc76dLvYR4WEFzY1rQv3SMutca2AJvEWgXKChoBrfwVu5BdRISS/sI0kbqSVLp0y1Xbc+yUf4OodtuGJFoE0bDajiwuSWyNKmQZUNih9hsFLk3Pk/DH0zOSa3QCA930WnbQuzigAHj2ivuf7NiIwfXdA98/NnKXUqrnvlax6afzDaGZx1ma1pD5i61kcaMrJxPNfeFuS75teKPYaP7ZIWK9IUUb52moE9pDQFEg4KpkVFExqqyLoyRt6+2I0EOyMaqERLK6G2hOieS8xfwg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 51.8.25.87) smtp.rcpttodomain=intel.com smtp.mailfrom=scaleflux.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=scaleflux.com; dkim=pass (signature was verified)
 header.d=scaleflux.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=scaleflux.com] dkim=[1,1,header.d=scaleflux.com]
 dmarc=[1,1,header.from=scaleflux.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scaleflux.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfDvV4d4viS25J/nwxWBysu3meKA1qxkMV9SPQBVogY=;
 b=UNbklsRpt9fmTijGMx/gBJSOSrR0FKIYwAyxqq3B3deem33wutB++N7ATOvWSH3nAK8hdyDUUgDgfhD3RKHfmLWOUrOX2DL7NQg+TCI16ds0XJqJ7RHJ90obhVlbh2aRVfY6+DxdMmYxaqWbqDLEdyrwhke276fnYN+IxN5edJ8=
Received: from BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7)
 by PH0PR03MB989098.namprd03.prod.outlook.com (2603:10b6:510:3ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 16:00:21 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::2a) by BY3PR05CA0032.outlook.office365.com
 (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Sun, 28
 Jun 2026 16:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 51.8.25.87)
 smtp.mailfrom=scaleflux.com; dkim=pass (signature was verified)
 header.d=scaleflux.com;dmarc=pass action=none header.from=scaleflux.com;
Received-SPF: Fail (protection.outlook.com: domain of scaleflux.com does not
 designate 51.8.25.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.8.25.87; helo=outbound-us1.az.dlp.m.darktrace.com;
Received: from outbound-us1.az.dlp.m.darktrace.com (51.8.25.87) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Sun, 28 Jun 2026 16:00:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPrWcpj8enwY+olUz7sAN4CuJjmSFCCckIqJRyoVzqarxe50Z2+21U8/2Iojth55CJLZKkqiibGdFrSGKiDI6Tja/FU02/ciirSl7ErZnffdICFcoSwa1AYklSWRRLjU2q+ZA5FlTBtO+DQcUycOpnBy3o48t7C5QI5SyohFPuRRLN1U+hJi2Deh/oxwk7WUGKVRV59yuvJY7SoBe7F7sURJ0hBhY4HQF4fqNFtWEtaDViRox097wmPsmTW9Dj3GpTCP5K/QOG+Z2QfFv8DZjgf5SwkNew4TdhiFCHiLjtaepy7VT5a+Cce6TzfmYofDuw7dlsB3zry8PNNtuRn9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfDvV4d4viS25J/nwxWBysu3meKA1qxkMV9SPQBVogY=;
 b=vldO4Lj6pBSHH2ztuxmj3HkGJokFn/Ol0aemkLBM0XmzaJDp7R7YySOzR5Z9zNjyxbPc+v7f/BOgnz9XxWYoC6HeBwH9xWiJCu32UvZ8ft58VAxOWsW0S8IzlzXFIvYxBWnPhHXnUA8G9i1MjQefsPBu7WPMhpm69jNQjIUxwS73LNj0uMrWDTlOJaZ9tHWtPS67kPdI8hGyhwucECVkIHO7U15u3FnDytxnXbrAthPWXjefUiWRK6F8MLRtIkcSoO1L2Z0ni3TeMAvpJGremIeK+grrccwGqg/Zy01Rka8vhUX6Exfg/cExRUMCjjbDarRoKJqQtr6DhjHNhyy61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=scaleflux.com; dmarc=pass action=none
 header.from=scaleflux.com; dkim=pass header.d=scaleflux.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scaleflux.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfDvV4d4viS25J/nwxWBysu3meKA1qxkMV9SPQBVogY=;
 b=UNbklsRpt9fmTijGMx/gBJSOSrR0FKIYwAyxqq3B3deem33wutB++N7ATOvWSH3nAK8hdyDUUgDgfhD3RKHfmLWOUrOX2DL7NQg+TCI16ds0XJqJ7RHJ90obhVlbh2aRVfY6+DxdMmYxaqWbqDLEdyrwhke276fnYN+IxN5edJ8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=scaleflux.com;
Received: from MW4PR03MB6537.namprd03.prod.outlook.com (2603:10b6:303:124::13)
 by DS1PR03MB7944.namprd03.prod.outlook.com (2603:10b6:8:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 15:59:47 +0000
Received: from MW4PR03MB6537.namprd03.prod.outlook.com
 ([fe80::52db:7790:8726:4540]) by MW4PR03MB6537.namprd03.prod.outlook.com
 ([fe80::52db:7790:8726:4540%5]) with mapi id 15.21.0139.018; Sun, 28 Jun 2026
 15:59:47 +0000
From: Wei Hou <wei.hou@scaleflux.com>
To: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Ming Li <ming.li@zohomail.com>,
	linux-kernel@vger.kernel.org,
	Kobayashi <koba@nvidia.com>,
	Kaiheng Feng <kaihengf@nvidia.com>,
	Newton Liu <newtonl@nvidia.com>,
	Kristin Chen <kristinc@nvidia.com>,
	Mochs <mochs@nvidia.com>,
	Dan Williams <danwilliams@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Wei Hou <wei.hou@scaleflux.com>
Subject: [PATCH v2] cxl/pci: Remove incorrect mbox.valid check in  cxl_pci_type3_init_mailbox()
Date: Sun, 28 Jun 2026 23:58:57 +0800
Message-ID: <20260628155857.239866-1-wei.hou@scaleflux.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618170356.25382-1-wei.hou@scaleflux.com>
References: <20260618170356.25382-1-wei.hou@scaleflux.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To MW4PR03MB6537.namprd03.prod.outlook.com (2603:10b6:303:124::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	MW4PR03MB6537:EE_|DS1PR03MB7944:EE_|SJ5PEPF000001F0:EE_|PH0PR03MB989098:EE_
X-MS-Office365-Filtering-Correlation-Id: d3742e10-249d-4a71-05a0-08ded52e5b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|42112799006|1800799024|376014|7416014|52116014|366016|23010399003|56012099006|6133799003|38350700014|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 uraCOt8jTZxFh3cy6/bd5WDeRPkr6N+nJR8anhrQDcx84562Dv44Rry03a5P7o6Q1d44OSxrCOb4o5jMHLcrmWJitxYrCSahZ97Em2J6ZwS8cl2el01g0jaYCKa2gKTrNEmvDH4nevWE/8RakXqYSPLg5ifXityNB41s8z8UIJYIe83gtWAZHLYsrcPJTwZEmSWu7CFRvVpHwOeUgASfFvKFgcdhe8IdJyMWjN0sCz4bmYg0U0LsgcaHWZwIFmTUmitzXtGRwUwdpPwqlhT4vhHp4zqKqkCe1LO1cThxThZt/oMYaeic6W4U2jWb5rbiV7iDJRLJziW4VYSHSL+CAhJxNk3ACHKbanSHhWohRJ3O5cMU+APEKK77tsqbKagn8qfHjI8WESOdXRfWIIX1d/hMaICvp7LWuvtDjnZk9kQjxVVNeuVTb904h5oLZPR8CWmUI4RkThG/ac9PR1jkCx4iCEeHtDh7vzU2OtcR3qvVEUfEfnJ8exTuttbbigwThXz3a2h5IAlfZW8PudUziLq4SzynBwD6bHZ5466d2tR4csGkPw4WFlimCVwx+ovgsOGrkZ8faiv0UV1Bjsl59JHTgldTWGN2s2aiKjf0/KLK7mqiS0tJIgxjbGarz95m7KYXvMGbsvkXfE1YM+zor93jXVm4vkQApBOOjHo2Bd9+40OSP9lFYkzF6knnq4QlcEQfU6YMO/HQUP8+BX6vLLT/1lsvXfoRZrLj0jZG0KM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6537.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(376014)(7416014)(52116014)(366016)(23010399003)(56012099006)(6133799003)(38350700014)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 DM7oEORdP9LfcUzKzj9gFDwclxdLwYU4m8WYlGXFGo00VlulWASvd9QXzMNp6YIkmPAsgnbT4QX9hK8nAdqzgyf88rWhCnmoMCTT6VhEWlpHSu8UxyxJ7/V2tf5RrFJSmmjiU7/DQGL2s7vm64nf4bHIk7pljlXyilZQJh/y6OClHSAfw80cJclgZQiaxPODF2NW8CBa6nmjIvh0pFSt9SMQCHGqFvnoc1U0MEEvf8PM+HglXcAIFf6hzIVHRPH2vkUWcoPQPy0KJ1D6phqpVflxCFFSFMfWlfOvAZeUxMai5bWHZji8TdUF5nXunlx22Z3YUobpbP5ZCm4T1Vg3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7944
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	15d55747-d069-4201-0412-08ded52e46b8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|35042699022|14060799003|376014|82310400026|36860700016|42112799006|1800799024|18002099003|22082099003|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9flVlI5TxIOAqP1YNflnpzubRvMY5inQrQRuzuUkgFJoiGjz+LdBmaf87KYoiDRcnYBrlLIVJOaeAp/dDGSy4PL3gpbcgF1UQknRAyQFq488Qsj0muv1rmsIOvMwH1ROMQO6RXsk0FNQq5WSoYYItPE322HmBUEP3g/I1X9JGfAdlRRCT0/c/cdNvJ9Cclqc8BX4HS7zyVUXMIztF8s8pjxZJLdiySH4yJ+C7cJQ5QMiNWiHq31i4fLrt9KYvZRPrtnSd/2XGPwKIj7TOpNG+rpCGwRkXcliaZsSvGm8gW8wXxsCthND4MzncZPAGijohplti44KXGfGSrOxhVPV0x8vuCh29NZ1bQPuyE/+cza/RIBZuby85CspSuwzlhy0gHEB45LlY+xEh6dExkEcwKEngHftRkXJlQTRAXwyLCbKYVV7qdIZCtj5zsLGs8BmcXX0fnKaKoZrpZLa6nnTodTX2GAff/H1VdY0FHVRvKT+CLoCjYij0o8jDC6OlWC6JvwJqRAQM+1j8xjQ6dayNHThUnny0GQAAKdoioOh/VnqOFkcsV/AxrqTix5gjHRU5gLqzrFIpcf0GgHI2GXI+sCCo+TP2mvQNlCQYg+qXr3x2iuZlvzNrixFBEBRcghcdm10ZVOv7+e38oYIgCtc+i+tQIj5f4HQS7HPNsCEcEnCWbKi3cnZXilG+DGsDzjRWjmTNsvpu0wScwcPpwNU0A==
X-Forefront-Antispam-Report:
	CIP:51.8.25.87;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-us1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(35042699022)(14060799003)(376014)(82310400026)(36860700016)(42112799006)(1800799024)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rphCLmGA9y9qgeCyX5eUNSTZ18gKOsORdrT67qEoQYq3zSQSRJ/Cme+Q7OPlxTndHsMd49QAPUVoF+kq3gg5ixXdsdjATzdTJ0fifuNPiICHcTLr2TTP7dwrun6TOSsQvNUreLOtTpuBjgKTYQdU3RaObsdmHa1qqieXNJKTI7Co5ZPR15hHtIz1rkiP2UeSXHkJEPL4ROCuY/F1K4eK7SOgyc1M1b0T+wkfYRGykjpct7wFjuL/nwVrbSS2ZqiXiQD4W1WV8SvWvUpvzY1bq3OfM2tEFoeKkxnpgn/2IGT7ME6BP11xD5pc5b3d9DrOhs1+SlqusorN7+43PSK9MJNPdXQpxrkSKCt6XhWPAp7eqGBr4BTy0+2Twq036P0XGGG6tjsaMY/LaejP+CMJd8H40dzphyf6qnMQ2BPpBb2IVNM7laDu+SjHTpV1b7oF
X-OriginatorOrg: scaleflux.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 16:00:20.9096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3742e10-249d-4a71-05a0-08ded52e5b77
X-MS-Exchange-CrossTenant-Id: 97919b17-0f1d-40f3-bb57-8fc93387f861
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=97919b17-0f1d-40f3-bb57-8fc93387f861;Ip=[51.8.25.87];Helo=[outbound-us1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989098

The driver's design intent is that missing or malformed component
registers should not prevent mailbox initialization. cxl_pci_probe()
already reflects this: the CXL_REGLOC_RBI_COMPONENT setup path only
emits a dev_warn() and continues when component registers are absent,
rather than returning an error.

The check 'if (!cxlds->reg_map.device_map.mbox.valid)' violates this
intent and is also technically incorrect for two reasons:

1. Wrong struct: the MEMDEV register block is enumerated into a local
   variable 'map', not into 'cxlds->reg_map'. The device_map.mbox.valid
   field inside cxlds->reg_map is never written by the MEMDEV probe and
   will always read as zero regardless of actual hardware capability.

2. Already validated: cxl_pci_setup_regs(CXL_REGLOC_RBI_MEMDEV) calls
   cxl_probe_regs() which explicitly checks mbox.valid and returns
   -ENXIO if the mailbox is absent. If that check passes, the mailbox is
   guaranteed to be present by the time cxl_pci_type3_init_mailbox() is
   called.

The value that the check actually reads is component_map.ras.valid,
which aliases device_map.mbox.valid in the union. This is populated by
the COMPONENT probe, not the MEMDEV probe. On devices where the
component register BAR does not implement a CXL Component Capability
Array (e.g. certain DCD devices), cxl_probe_component_regs() returns
early leaving ras.valid=false. Through the union, this makes mbox.valid
read as false, causing cxl_pci_type3_init_mailbox() to return -ENODEV
(-19) even though the mailbox hardware is fully functional.

Remove the check. Mailbox presence has already been validated by
cxl_pci_setup_regs(CXL_REGLOC_RBI_MEMDEV). The presence or absence of
component registers is irrelevant to mailbox initialization.

Fixes: 8d8081cecfb9 ("cxl: Move mailbox related bits to the same context")
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Wei Hou <wei.hou@scaleflux.com>
---
 drivers/cxl/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bace662dc988..e44e5d209900 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -691,12 +691,6 @@ static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
 {
 	int rc;
 
-	/*
-	 * Fail the init if there's no mailbox. For a type3 this is out of spec.
-	 */
-	if (!cxlds->reg_map.device_map.mbox.valid)
-		return -ENODEV;
-
 	rc = cxl_mailbox_init(&cxlds->cxl_mbox, cxlds->dev);
 	if (rc)
 		return rc;
-- 
2.43.0

