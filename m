Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F89E1
	for <linux-cxl@vger.kernel.org>; Fri, 17 Nov 2023 00:40:03 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="119419690"
X-IronPort-AV: E=Sophos;i="6.04,206,1695654000"; 
   d="scan'208";a="119419690"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 17:40:02 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 47A33D5029
	for <linux-cxl@vger.kernel.org>; Fri, 17 Nov 2023 17:39:59 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8EB79D157B
	for <linux-cxl@vger.kernel.org>; Fri, 17 Nov 2023 17:39:58 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 174DA10210
	for <linux-cxl@vger.kernel.org>; Fri, 17 Nov 2023 17:39:58 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B3D2D1A006F;
	Fri, 17 Nov 2023 16:39:57 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-cxl@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH] test/security.sh: test keyctl before excuting
Date: Fri, 17 Nov 2023 16:39:47 +0800
Message-ID: <20231117083947.2211323-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28002.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28002.005
X-TMASE-Result: 10--3.253000-10.000000
X-TMASE-MatchedRID: URRd+XkY8EyHYSb76u64f/CCu8kVj0TR0NnUUVMlTKbAuQ0xDMaXkH4q
	tYI9sRE/X5ZfmW1Ym4UWgRiHQt8EDGj+Msn9Q6Vo/sUSFaCjTLx9LQinZ4QefCP/VFuTOXUT3n8
	eBZjGmUzkwjHXXC/4I8ZW5ai5WKlyvK85lLaJKyalcK+/pDc0JEoohAQ1FTUSXbTdsEQfxblglE
	ufKWgKlfQO06O02EYc9rBR8XZ05aZD38bpBL6TiKQyUKOOe22GEWW0bEJOTAVAdUD6vW8Z1mZAM
	QMIyK6zB8/x9JIi8hKhgLRzA45JPQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

test keyctl command before executing

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 test/security.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/security.sh b/test/security.sh
index 4713288..f954aec 100755
--- a/test/security.sh
+++ b/test/security.sh
@@ -219,6 +219,8 @@ else
 	do_skip "Missing input parameters"
 fi
 
+check_prereq "keyctl"
+
 uid="$(keyctl show | grep -Eo "_uid.[0-9]+" | head -1 | cut -d. -f2-)"
 if [ "$uid" -ne 0 ]; then
 	do_skip "run as root or with a sudo login shell for test to work"
@@ -227,7 +229,6 @@ fi
 modprobe "$KMOD_TEST"
 $CXL list
 setup
-check_prereq "keyctl"
 rc=1
 detect
 test_cleanup
-- 
2.41.0

