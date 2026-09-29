Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012049.outbound.protection.outlook.com [40.107.200.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C82C11CF;
	Tue, 29 Sep 2026 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647463; cv=fail; b=KBDh4v44VffWA6nkfInHsc9so20xY+J2N8+tTToFVkzhaSRxdc88k1Wy0y3JtsZPphe4gserQrZhh8XAEqi5vg6uhw3TZM9VuIb+9IOc88cud79YAo3dmvmGYi4XXWugMqxFU6d0IcumgkgfX454xABi/LMpf2FmRMTQGE0A/Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647463; c=relaxed/simple;
	bh=LuIodRnFN3ezrYkV6zL21QjWVYQHRInhxLm+aNHHJWw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JuvXvTwWb/njOSEngEh5Dl0wtbgKKA+KnIVd/RO3jDkxatvCFNMRaYDi+wIg7twkT1D9KNI8AXElPjfJ2HBsf6WZ3rtCunFM/YfyS9xPeIpvqOr4ozDDde60e//PmRQ++VgbFCAzzqU1OZj7k01S/35TjGixHmkYWjndsfandcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mDlymzAS; arc=fail smtp.client-ip=40.107.200.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mDlymzAS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVwDMhG1ZWpYf6nxTDKAsOUMUkq5LkDivWGTdkD5JY1YoeR43w2fBTZoLHpZBTjFmyZrERTKOcg04XetYpegaIiV+Cnozhu/hBnVKcyJWZC53ETNXHbJCYpIN+ISdVLGfJdMys6pvUd7NM5OYAMjLKWiIJrAdOG3Aw5RaNtN2V+mu02/Bz+1OzpyeYsa2CCUnsfP0GaZgn3nqQyveOq/mdCUB7GTSIUxDFk5JGtQ8mU8PWlA9V4PPop27YR0P0JFJde3/Wewcqe7kawl1TGkWT3aagygFQ2hss3NAWInPH17zYVCqNJ+5PIONF4O5OWsDhjIVvW4x1SYJ1Ss8OcdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhiSj1sO50v5GuxqerT+19lhyGuJDZz2sPfCmVpwjAA=;
 b=GRyRcjRWTrak5CRgNh8PJ9+apC5U2f0tWrOs0recgoi/Xd/YobAj1lTq9OJM+F3eEKHfn4kJRuO9xyyOf154v09ZxlEtxyHTg92Re1ae7/EL5KcrHHFYY4mz/ISdnovdpiRwfSU+vpyRZhBmF2wkonU+KB8l19Zo3sgNw65iVCSclJdJ9cGepjkkZohKOMRy3Gces/bwC891GCn8l5mNb+CuK2DkUjevTmQw1cTiBf6g8AEjGI4wXyrbB63ZosrzTx6MfC3vz+ielkskoNXdn5hu3IqRVS6EeFK/o8prf3o2zaCLa5FsJ1u5vhDPW0EeE/vJOcYpOEN2/3zMxvdd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhiSj1sO50v5GuxqerT+19lhyGuJDZz2sPfCmVpwjAA=;
 b=mDlymzASjsxg5WDvu6TOgxhgZDRDiMlHG9/qfepH4xhqVGZYE6JeeQVxSErs1R451JBzqdj+kkVMU9mdM2B87Gx7sfCLFHu71VkL0gw6vHBAmtRlB3trSFpCOrseiY0oSPU0dcf7+EU34BS7biPYfetWN7iKBaFDFtyv7iFgDJ3ZSnn4glqwi0/kQAxjoENoa9P+yBUve79S1O7bMcNOzYXSrGxDVX8Q3+zQgqZrkedGJYnv3xaaczK+2a9rJOXeA17ydsqwYwYGvchXRRN41W2J8+QUaDP8ktHzunF3hUKEnPpPcA1Ue7d6+kJ6FWXBTBWYg3DK4+fEdZ2yDbXbbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 02:04:16 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 02:04:13 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org
Cc: ming.li@zohomail.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH 0/4] PCI/CXL: Guard reset recovery against inaccessible devices
Date: Tue, 29 Sep 2026 10:04:01 +0800
Message-ID: <20260929020405.9724-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 040c6069-77d5-4a79-21ac-08df1dcdf558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	U0I6DhBhEzV/Qf3Z+ALvp89CZ2uhy+N1jRWImo62Qk/K/xTN4ZbyfRx4xTD33ZQHHVYUpPoiUZ70JoVe/LBFAP/wA+hZ3hsp5qpFLa1TVCTl7bK0Y5/TSf2HwtWeOAkhpg9euj3RI5JR63RBQ4yWanztHl/lPWzdDn3rd7K4jZDApTReU3OowiH5pmIcPeQMgTIfVI2sJzHrau6vQv/7Z1W/QAP0XCz9Ux+Y9VQmNhOn7axW2f2kWUT1qGm9YzK5f/yJqo9CRKuYbNWWYRrTRVU/09mZdxL4LY0qBdA+d/+IWqqJDFpiKxeTokp+0791hJedBFmpUQmNechZLGDwX0MF9S1JHTx0Iu5wacPB6aAWNIl6MNOW0JBS1SfN2r8//dWOHt4vtyvvY6HbY7AJRvg8uy9vZfJkQ1JGJQ4r2ZrKzH2uHhWw9AKFo8yvu/I7WOZobGRqeRngWjbEiRouyzB/I9fc3Hvr3JOyBotE4hLaJAk/yU38ZoCQtJYcUzkvbKWbHMAlANKxQUZ5oG0vVJ60M+2chIFGfjxdgTZCjvATmPQ9lPjMG2bqlgB/rDGPiPl7jUT+fyfOsbGXiO2NQPi9sVV0BRjx18+s/3eu7zNIrYIHReAnUPjzNxDnj9BxxOPcsGjxGywMNDqGhZm1iHKSRH68xfG2Bs1TaJFqeBY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6t8aQ4HL7laT5doCueymnj3m+pXJc0jssKkNxJZC3bNsb6I9OjVqEMShCCk1?=
 =?us-ascii?Q?wz/kzPFoQaUL7W5q4QuJDaqcNcTLLCHKZP3JnVHSifcy4tgEtoz32f/NCsFd?=
 =?us-ascii?Q?h/jCcfkYALc+4Zi1ihZbnrfwFHieTPa4TwEYxDhieKqNgxuN7GgUhJsykOEj?=
 =?us-ascii?Q?epnDmIiw1/ftdZlc7+chsHN7ZrSg8gdPieDagukgPxJjNVXQtf3fMLJFxClK?=
 =?us-ascii?Q?9zLhgAqzUNmuOz+6Y4kWhDM7p7isKGxl/PSEeUH8SKhm3ft65nNkYREZaAA5?=
 =?us-ascii?Q?ZviVTQZv8TX0hLh9abtt/lnEavHn8BNdS7RfZvL6eYHzUolTIwKkoq2U+jE0?=
 =?us-ascii?Q?7NwT0P9age1MTVFlGt232Kaz+zcxYA+Ms9PIyRzok7WIkQyfK9GKvWrc/cjE?=
 =?us-ascii?Q?T4LNbepfAh7Z4cVbZFa1PJ/x87OAZwrZiu/KThiFQWCHB08QZ/wrN/degoNe?=
 =?us-ascii?Q?PRoeypRU1F1nLy35mULf19qM70RwW1DDtSMPMc1seIOrvOnn9zM/PECBun8B?=
 =?us-ascii?Q?EC2HmmNJI0IfjSezrxsiclYcDmIQNscxI/dFJJKnEj9g6Q+WupzOEykA90QS?=
 =?us-ascii?Q?JouAe9zrXU9J9nk1ULVl1gurkIqsbNbAPitzogLXdWdI9dnhWStfNnFqLlsb?=
 =?us-ascii?Q?umLsaHqlfKuaGP0pJ3GWVgDlp/7rqdezulALCjpL2/Wf5IT83PEsJsUlfDF4?=
 =?us-ascii?Q?p83Z9NCSzA8QL7FdRWteFiRpuf70LAWOm8AheSioPGBPbA0iayhYOEDn61JX?=
 =?us-ascii?Q?UJb+jaJnsp2diEA8jGl5J9mF4AIWxYxr59nQssQrsp3u11fA6XgR7IxqSCs8?=
 =?us-ascii?Q?A1HEI+BjFA+qzVWfTcBgfWHr4Sp5ztghTudDU5YgV15vLVf12NRKwvkfh//P?=
 =?us-ascii?Q?sgg6Nr9aZaPpfgceGQ67uX45b1m0XK8GnKY+Elhpni5TMxvO18Hp4qQbI8+h?=
 =?us-ascii?Q?j/HgJLnPRSvpWmA4ybRhxGYEC3cZfk5+m7Tvxm7IH6Wj6ur+qoKU7Ds6tqpI?=
 =?us-ascii?Q?kmXi9+m+xuzI18bvIENNqQL+lwbquUOBlvMRZyTDy2ChHkB0JlhbSXx1Wk/a?=
 =?us-ascii?Q?IUu/rTzW2f46nTtolxL9TgheHUVMkB79aEKf4KvQCKfuLik4ocxz0GSK5WSe?=
 =?us-ascii?Q?Lpzpcqsja/KkO9qgpEjjm3J6cUH7UsoJDHVA8FxVKCe/Es8V7wWkmswfWzUn?=
 =?us-ascii?Q?Ly9uzihdMzu+cMmprF5GTspmf5fX/5RTqx6k9NvdwgHV0o7AYas3y5VISCkH?=
 =?us-ascii?Q?RdCMOMELcImUXFKXn7NntXj2a5bi4dMPPhYYFxpq+3sxYrDSPkmFqBIZLyhk?=
 =?us-ascii?Q?PKa1AuO6ryrqpKaK90LxS0u35f5ULrOuHI6LN7mRIa37nGRxA9850ucEl81s?=
 =?us-ascii?Q?8BnUsaoRjZD73gij2gJsk71lLAvsYW4E8eJ5u6eu33JuqYBGmP0Dhmvu6jvG?=
 =?us-ascii?Q?nY1J2FVMv703fx5cm7X5XRflZbfg8GLQoIg+YnYR97LK1a4Xqcpls0X93wVg?=
 =?us-ascii?Q?Q+rO4JBsCNKTNeMhIWcmgmY3LtWxylzqpOxMyAfqIhB/jd7h1bzsZSFNQdYy?=
 =?us-ascii?Q?0yXX/ixO3AziBqY9ELQF4HCUJ2LneyAWaJiN8fx5so8QB1rv0+rWYUQMsVld?=
 =?us-ascii?Q?1SqSRacLcjfyLSoOKfB4LUMcZ7bf/Vbs+L/B0oKC8oZwP6klsMTIGY4/cX9k?=
 =?us-ascii?Q?Sp49g60lvTs/6o7T+N6XXeK7Dh/RDkSXgBbpc7vpD8s6c/Q1uYr96LSoEEjQ?=
 =?us-ascii?Q?uvEH2oKL8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040c6069-77d5-4a79-21ac-08df1dcdf558
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 02:04:13.6345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQ7FUIrzB7VkPIvAEbUIy/FEhbyYqG9WR7zGLPGtvh4Yv83h/h9ruBVgF3EvUqqHq7Y9QkbW9Efy6rS1/cIIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

During FLR testing, PCI configuration reads returned all ones. The
kernel could mistake this for reset completion and proceed with MSI-X
restoration. The resulting MMIO access triggered DPC containment.

This series addresses four issues:

1. Reject all-ones responses in pci_dev_wait(). Use Command-register
    polling for VFs, whose Vendor ID legitimately reads as all ones.

2. Return -ETIMEDOUT when readiness polling expires, preventing fallback
    to another reset method.

3. Check configuration accessibility before restoring PCI state, while
    preserving driver reset callbacks.

4. Skip CXL decoder MMIO accesses when configuration is inaccessible
    or memory decoding is disabled.


Best regards,
Richard Cheng.

Richard Cheng (4):
  PCI: Reject all-ones responses in pci_dev_wait()
  PCI: Return -ETIMEOUT when reset readiness polling expires
  PCI: Skip state restoration when configuration is inaccessible
  cxl/pci: Guard decoder accesses after reset

 drivers/cxl/pci.c |  6 ++++++
 drivers/pci/pci.c | 16 +++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)


base-commit: 9eb6419022d81aac6d1d9ead0e1865b451153da5
-- 
2.43.0

