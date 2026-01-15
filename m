Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B952E090B;
	Thu, 15 Jan 2026 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516353; cv=fail; b=l9rehP9b87hfLQ5dy1CNxkL9iPnBL79JFQ0upgk9bxvhUUK7u1+dyW3SGfMRyYSedqlwfSsFXVCf45cBHyJwn6Mp2QXMp/n9s4dXKXeMK/XBxCa/6EvveLDHQp2feTtDvpF97SidJxodGbkuHEcqJeUew4jq4i3jmTskaFo6TAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516353; c=relaxed/simple;
	bh=te/Oxpg2XUAnd8bA6kBnPy0kUcLnZqrYaQMottAE82U=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=gbA9cTSOcvfFovsHuM72EWCXNoBcSXi3ifzZHlgfckX3MLaMezKC2JslsIpwqsr5bWDAwgl7YXiX3Q/O0TpQGgE0RUz119BrwiLU+ik42lBNY8Yj6H63MsODLYQHuoMkqZq36EGk1qQOWNl+dgvtjW4I0Dpirshx2QT1YIawQNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H/pBFLrv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rv2jGljG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H/pBFLrv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rv2jGljG"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FGvk6o1940285;
	Thu, 15 Jan 2026 22:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=np8YzjmXkBOiUpAOiE
	4O36ozEXHg6NCR9dJtk5pRrQ8=; b=H/pBFLrvv2ClVF2tfiZHZI7FQw/RApWyIc
	B8/1CLLLhChYurVUkhtioEH37N3gJalGjoIm2MHSWG8tk0HxCAkmzKQwkYM+NhKP
	Obc4QcIiGBw+haD/KI+drpoChZvY0dLvj0SGs9e+uoaMKScaIqsmfB3bTbKi8R03
	Tsb92Aihx9vzF1pgLmLt9LqXArN0Gjsw8V/9oa5oEI9kkA52Dcbw7EKjGTEZYIHt
	Hj40HO68Qqp0jQi0RmVI0WNx1xcvjlOR11KuPc+zTZ9amL9B64DKxGCFoKXmxGSj
	dWIhwGUkgT1oCEDMepb88el3KIrsp37s7u40a9TmCrkUX5jVHEsA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5p3c9ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 22:30:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60FLUNEM004868;
	Thu, 15 Jan 2026 22:30:54 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7bwpt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 22:30:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV5ghA5scttG8G8UR3DGl7UL/PQiuLZ1qPngRTg3vPga9eA6ImfwjtI/tUIu5kzVFSrM5ZuLoeLIxZEHzTolVeq9FKEVV8EoDMKSEQ48xnDlL7wHo1u4ojqnNlJIiXku1/UnyD3b/+q78bdFDMWSVR/6d5OsKcVWb3ZGKp4Ul8yXp4CZoeU34+yJ5sfLS0fQuF9jECqMPml3PUiO8VNPp+fbde8hHI9U/3s3D/SIrI3dwIWq1EtDipld4XSV6JHIRTcS/CaSD37Q4JmqjoxezqI1CyNn5HrCmu/nbeBWyufCk60BT3M94gc3bVK8BjqDZ4cN44WdgNQK7Lzun9RTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np8YzjmXkBOiUpAOiE4O36ozEXHg6NCR9dJtk5pRrQ8=;
 b=ZHSGTMlK8vPKU31+CMpStP1gMMMvpazZzDjtPtXx0GAwoBpeOp0ANsXjHbB0wdDtNomGeDb4CTCFWN8iS8aH2sR4Ld2GFd4wH/PSobDPurObesepljsC57dPoanoUSQEYr7lXBYO9PHp7TzMWUig72S2JTjmKTVBI1IRCe7xlxXHk2VsZNk1AJY6MxXBSntXm2NzCUVpaDQqG1kQJ/XswYw4Si/seLRBiykabbVv1TNzErzcmlb9KHF8uVvjZO7qem0IVtcD0Wg4OQb5nyv6KE9waYlvJhRbD/Pt/+PXXMxOxOK8LJeDGf2TOtsuwjxYdqaHngioMf7Py8LI1h1aUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np8YzjmXkBOiUpAOiE4O36ozEXHg6NCR9dJtk5pRrQ8=;
 b=Rv2jGljGijgX3qiyY6NepTzbmUEVlgZLnWiysVblYSF/blsjKAG+GD51+sDG1hGpMKh5DZz368dCqXMtvEZzJ4PVe+X47HuK6ailnMeTxmfvgFurv3s3pkDOhxi/0Ijhy7i1q/FpuQEbbMErKnqy3kbQs3ePFeQcP/bXRfrTFDU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB5903.namprd10.prod.outlook.com (2603:10b6:8:85::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Thu, 15 Jan 2026 22:30:45 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 22:30:45 +0000
References: <9daa39e6-9653-45cc-8c00-abf5f3bae974@kernel.org>
 <20260115093641.44404-1-lizhe.67@bytedance.com>
 <83798495-915b-4a5d-9638-f5b3de913b71@kernel.org>
 <20260115115739.00007cf6@huawei.com>
 <23513e86-0769-4f3f-b90b-22273343a03c@kernel.org>
 <69694b06835e_34d2a100b3@dwillia2-mobl4.notmuch>
 <65cdc2fa-b6ba-4422-9537-feb7d3a33210@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: dan.j.williams@intel.com, Jonathan Cameron
 <jonathan.cameron@huawei.com>,
        Li Zhe <lizhe.67@bytedance.com>, akpm@linux-foundation.org,
        ankur.a.arora@oracle.com, fvdl@google.com, joao.m.martins@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        mjguzik@gmail.com, muchun.song@linux.dev, osalvador@suse.de,
        raghavendra.kt@amd.com, linux-cxl@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Gregory
 Price <gourry@gourry.net>, zhanjie9@hisilicon.com,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
In-reply-to: <65cdc2fa-b6ba-4422-9537-feb7d3a33210@kernel.org>
Date: Thu, 15 Jan 2026 14:30:44 -0800
Message-ID: <87wm1ih5kb.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:303:8e::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b3dc8b-b741-46bc-ae2a-08de5485b983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iPRQxVYLnze3uQBmxSOSZu84rYJcqzYTMcHJpG53V6r9X2F/jwOmU1cDY7kl?=
 =?us-ascii?Q?glWZNjUPGrNFBZdlkPlNy1151hfFn7ftdoEGccXsFi+rFCTYoCfZug3TArdy?=
 =?us-ascii?Q?t+A+/V88aMjxSRRc+cLpkI1FlydquFpbKXxwZUo6pWFebTtFi8jwInKbAa19?=
 =?us-ascii?Q?RMQuekmZ73JBP1tykxLsL3jQH4SnuPGWZ+pSERFNrb32nwIYzgXHlSf23Yjl?=
 =?us-ascii?Q?t78mfujGtkljt9KdobMdwiDmgorUG141YgYCmia+CXrLTQUb7zVmndJqyzBw?=
 =?us-ascii?Q?6SbWKk9S+Ih8DpUhvEQ/TU1eRCPg/U+Eg+QKbzbmp0o3SDMA1GbG2BkC2Koi?=
 =?us-ascii?Q?165+omx4Bt0FXY9FLXxaTjCYRYLsEPnn+eq9FP0ojuLS3HT1o6mZ4DPMIiIB?=
 =?us-ascii?Q?kmojamhuKjCC/6FLCkjWwg/SaiSD5/1Lm2mN59CWAt6kGyuKVbv45ooQfRiB?=
 =?us-ascii?Q?JZ4yrvwK5OzrBx5xKL85RgUhB+yNLdAd+LYpHifBYiEwgPJ8yDqq2gbczmLQ?=
 =?us-ascii?Q?hrm+FrnvTwl6r5uYrDVrw0ZfoXIz8W5/KF0xWeYV/8+LKQud4PIbqNjLSRS1?=
 =?us-ascii?Q?vrf6XYFUur7kkHHIZ+0ldqpQJvtKhY1zrvkY5aq9cErMRE8JCoaC0sGPRXlE?=
 =?us-ascii?Q?kgYLOKQpqrNjWBI3NiGeCsYESAFQo2sHh5kuGhOw4Svq94sbLt2go5M9fytB?=
 =?us-ascii?Q?KTSSSfWZYhoF+YOR+fFxj9MhlxPyRRk4x6xiTv8nhQPCm81XY8dVf5oPMu1S?=
 =?us-ascii?Q?r3yuid4RpprqzOAEUYlIIY/c5Qa7yiAbfr2SdpMscHCGe+atbO6uvGwdakxT?=
 =?us-ascii?Q?brzqviKs2UjxGchEtTjEqaRc6f80fO5HglCJRhkwBloukC0XwFf2bLTR+h2a?=
 =?us-ascii?Q?uG8V2eWxt3BZYmX7gZEPw6CyJ21cmvOaxkVdsx/oZUTU/J5JWA/2bRG5aXpR?=
 =?us-ascii?Q?+TU/XHn6avhKthBdbvdgPnfVrrRcI2vVuHQk6E1VTMvfJquORZ7saGDz83QI?=
 =?us-ascii?Q?O6G/Y9+egej+MwXvpXiu4Zy9+u5uaJk3ApVISaqFiD/8xL4F3maB3m8Fz2vL?=
 =?us-ascii?Q?CFckCap+MKKnG1gN2bTxAC9BTX3FTvdSCjqyNPka6UC6erkxg2w0KcQPJhuk?=
 =?us-ascii?Q?AKpmxWmJZGcB1RjLlWnG66LxZjOfuQdB0Wct9xpwvd/CjCIWtxZg/8jvfgTw?=
 =?us-ascii?Q?p5d8I86RTCkCyNonsQQ0340dAuLmy0/rkgoBR3bcP2xdX4cR+cJaJWt+CvjL?=
 =?us-ascii?Q?VO1Urd/Edaoazki8kaqxZLV/7POnwMrTLkMlxPjGFdSBpa3vFaQvDWSC6adq?=
 =?us-ascii?Q?pB53XmuEiFmv8tcx5Rnb2NNZWTXEOqO/tP2EpcQAphhTiAK78YPNzAaGSsbP?=
 =?us-ascii?Q?6Bq2wqGERkHnZ3OJ3bNapbOViSnI2C06EsCYxJALlGNRaSFrNUE/MkhN2N35?=
 =?us-ascii?Q?kFs+wBJR1IDuFkoXo+lhgkn7MjcF8JNz9RlvMbzb+Dgs3Ze4Z7taehenqt+8?=
 =?us-ascii?Q?K11ssW5j/CpnvaxBnpJChqpqH0QJT29s2DSA9fNm3FHTbey/clqY47RXdTfo?=
 =?us-ascii?Q?TrV1CbNQKyVi1NNKSi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ugGWGZcRU5M8rsBVr10Q/G1UAabmIE3PRIkJ2Dt80Rl/F70F+grZFQuy7unk?=
 =?us-ascii?Q?qtEo8m7onW2GPZfimc2hCmsNAr3hEfwWycJy370FYPTeN8uI1J/n+lOoTN4E?=
 =?us-ascii?Q?kd6QJaIEWhSYVJrHPnnKX/25wBNR50GOfossAGRbAJy070MmK52TL5bLUPgA?=
 =?us-ascii?Q?++24Gx7TL0WkiLr9f1yXGPnhbIBa7aQg+STZdMpKMijOqsdqSX4DURJqCcmK?=
 =?us-ascii?Q?iZFh1fmpskEuN+xaa4kIdGThkM4BmMiGLze+z15cnZu/a8psJ5Q7HkEl2oo0?=
 =?us-ascii?Q?0TT/6jHFDjhxfM6geEY0VSqmJuTCXwPGVe5yz8XxIQs+WSiPRCL7SL96zgyA?=
 =?us-ascii?Q?qQHY8n3t5X54Z41nFK918G+Twl1oSAxetnPzIFZij11a6VSIJnaCI4Cw3Sh6?=
 =?us-ascii?Q?scW1IAOUeWKDvk82bbLIys4ywWoWnWemhrBZgsdHMqzED60e+xP5BB4iOfGG?=
 =?us-ascii?Q?36oczdwl1JGXTqaMdWhHqOJXxKIoub5NfKfQOL7UNjDbUzx1OH1Cg+6mT3HC?=
 =?us-ascii?Q?03blpdjk3650hbRa69Qft6aOFq6o8JPw9wsif8/1fpbL+iLACMxf+/COQPxe?=
 =?us-ascii?Q?GswxmbcSiY5qIGx9D4XlFZ3Ah6uZOuBDGj4pzzDtVF2u7z4hIOGuTl8wbHps?=
 =?us-ascii?Q?gaTOs2EpBrv0QhH1YldjnBuSipPgY98P8SX/SGxxqxm3NKGnLGmHWB2GDEP5?=
 =?us-ascii?Q?d11IVyd0Ha9R1JZrAC68lw7yEYLyASdU+bnhinynIwBgZGIykm9H05KuxLE4?=
 =?us-ascii?Q?VujJjYV57TkYvk5K89OeIjJ3NkicjyS0zq9vqzDIyOmCcx36SRMQV0rxQuzA?=
 =?us-ascii?Q?Hxl9bcf8n8jGqPfGvKmanzo5qAld19ig2ic6LF3oq3lGxmWBYThvZpjfI+bm?=
 =?us-ascii?Q?xPu7I09EOZ1R+IbkKTXZ++46hv6K/x8LJGuKrtmzcBHX5HSr+aJeeSnTF83q?=
 =?us-ascii?Q?WSITikcST1nYhY3LW4//cWFZQz7hnwy0kkGrMLvZPXwOqReEdEy17QxU3hRF?=
 =?us-ascii?Q?odrq6aQ48CyIBri3/Exd3hAsntr9rFj+rgTACw31YncwnXoFFzeSxTPWLkVu?=
 =?us-ascii?Q?xNJg+UfTbapcmYR8MiNpdo6Krr2c7MuVNeKecQSn7tT5oI1hGHPqmpl9PI2i?=
 =?us-ascii?Q?YZqWWs6Kt2rOn8kCqCwDvHRnOlC6BiLR8aw2maGmQPsbUHORghWYDSDNNDx3?=
 =?us-ascii?Q?icmF71LiJH3bLqG6WvDg8uRwGp/1Ch0BSmqf3UIcrw3aGaYwC8F7Ol35e61v?=
 =?us-ascii?Q?kiuFrryL0P6sGUhWD5WKrNSsSkQxK6xZX859Ep0BszMuO3OVGHHt+EkROZRM?=
 =?us-ascii?Q?aWxTZn9VPW/QS13tuWDZWG5FlbJTf6hO7tOcPObwFbjqUtG1L0DF/osIKd11?=
 =?us-ascii?Q?P89FxFleId3nRLFrDkFPXP8FOIpoYuFxUtP70gtWZPp9Lop9S7i0LN43pw1G?=
 =?us-ascii?Q?DZxsOwPg6HS0JoPwDaS1p/6bTdOTvL5k+PAosD8h+KtPax0t5MLQoLmJg5bT?=
 =?us-ascii?Q?kQn9BDVv3PTO8/fe+fWhqlG8dJKhptl0Gam9aUU9hvPIu5FHADJxyjI3vvg5?=
 =?us-ascii?Q?0q+eID4+Gc96dmSk3L+tKP7y3DWmMwxs6QsD+DOiOAqkc+6twx/1VOo90+5v?=
 =?us-ascii?Q?qJIjV0I+ogMgZdlK6pAnsCNVFmsnB6ZiUVXZCPvG2/QrdOhxJ+aqcemQfFPY?=
 =?us-ascii?Q?0vboXY9o0MyFGiC+xZDq6qSwOOe8zB6B36oAKBq/C5cl+1p3gNHmQAi0JgxC?=
 =?us-ascii?Q?mRd6g8h5uECYas9J2Rb/X7Ck0oSVilw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9ZXSz/x4ogY6LuBL1VZ3K+4xyFWhLHFowW/pzLr937S42KQoQ3EElRhId1AxhZkApmRWc7XHuReu/pVGEPhQ1Ag2ymuIv0/Q59AjRUJi+ojyhxsptkBFxtHdgUOmsxchX3r7wi1DvuiA7LHDyhd66AXRJgEfZmtqi1LyRWO6F52OkGVCdz21yLmVXUjyQ5lXFxmiKSqiXJsosapzWQZzCLrYzrcnMhFyYneAJ4enxLpfyeooPPffdk+olLhjk3L9+Pb7SEK14cdUUd94f+VLweNFRLrQ9Swe8X7nKvFjNXLm4zeC+G9JGmJ4laHD3XzY9XhTJTnOeCsMqjsWWWfaDH++Mf1KikLDWKQXDYAn7Jbb3Lh+TDFXFhRzOOjOO9plQUyctp+NLlgxluAO2szoiqu38dYCOPZhoETiGauYdqD7+7AzKjoJXRbVhAnQWKz5aCHeadXJWn0zzdgJQU+J8JRVrIVpRtvlNeZlI/JFACsIpdIK7e9f+IaJNlurXndqEJqt+7zMxqze4WtWNFMmjUykcGhAzGc9BMf8dGwyNNN1HuzZsgti7jr/xdpHl1VUDCueeaCBi7oS8oMLeryihLKCa8FfYgJHJmU/dEFu1Lo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b3dc8b-b741-46bc-ae2a-08de5485b983
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 22:30:45.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVDTIP6+Inz79wLZvLJXeBHp42sc6lidgkuQ2fdEf47qH/qKI4MeYAu2TAj5U+QPOQYZVkG5gL5ApNIY6tiobM9p0q8gT+OcodLT8p805FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=687 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601150176
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=69696a9f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=YpDwce9Y656Yy7AOgbsA:9
X-Proofpoint-ORIG-GUID: uVn7KFt-_0sKPXaC4b34qdv1uzcVdbww
X-Proofpoint-GUID: uVn7KFt-_0sKPXaC4b34qdv1uzcVdbww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE3NyBTYWx0ZWRfX8V3aIVG7T2Bq
 Xen0YZJnC+8PQi6SQolFd+9LuMg/THwOWnecmNPhtKJlxUHia14Hjm7Bu2jyQ6Dtmcx2aLSoTvs
 htgeijNa9ZV6E4DUuur6qfrGsVTLjlaQjvRRFG3nCJ8mzd6aNhhl9oFqspjPPVywYazDCY0Q8Tq
 YDXl7mKEL+jf0LNqZbMH5va7IOFlMYw1xRxh5Z+Wl5Elc2ZqLzjF327c2E34hH2C9yS2mTM4pBB
 WsR9L/ezyef2kdJv1pBwijB0gMMGnTUbrOUNA5JzdZYlivKoN2SHe1M9ESL5gheneHgmiujDzwr
 3K2I+wjlFhD3v8YYrBE4fPoUxEpCEY/6EhzKVOR6TFM8lLHfkldZlJcBCEphGPoN+P9g7+W1CPX
 SvhFN2SxVD7zMhT6U8vKLCQ5kAAoyVl2ivdmJxV78w8998J7MGgIwbB9Bdajj0SAiU5oW/p93Wj
 1CGi5nBv+2EPwXjnHpg==


David Hildenbrand (Red Hat) <david@kernel.org> writes:

> On 1/15/26 21:16, dan.j.williams@intel.com wrote:
>> David Hildenbrand (Red Hat) wrote:
>> [..]
>>>> Give me a list of 1Gig pages and this stuff becomes much more efficient
>>>> than anything the CPU can do.
>>>
>>> Right, and ideally we'd implement any such mechanisms in a way that more
>>> parts of the kernel can benefit, and not just an unloved in-memory
>>> file-system that most people just want to get rid of as soon as we can :)
>> CPUs have tended to eat the value of simple DMA offload operations like
>> copy/zero over time.
>> In the case of this patch there is no async-offload benefit because
>> userspace is already charged with spawning more threads if it wants more
>> parallelism.
>
> In this subthread we're discussing handling that in the kernel like
> init_on_free. So when user space frees a hugetlb folio (or in the 
> future, other similarly gigantic folios from another allocator), we'd be zeroing
> it.
>
> If it would be freeing multiple such folios, we could pack them and send them to
> a DMA engine to zero them for us (concurrently? asynchronously? I don't know :)
> )

I've been thinking about using non-temporal instructions (movnt/clzero)
for zeroing in that path.

Both the DMA engine and non-temporal zeroing would also improve things
because we won't be bringing free buffers to the cache while zeroing.

-- 
ankur
