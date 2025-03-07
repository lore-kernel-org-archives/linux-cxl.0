Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACD1A2544;
	Fri,  7 Mar 2025 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329361; cv=none; b=HLw63/EsE41OrWnSvIhwYUQarrkzg5MUktbw3FwXM960sSHlmk93Gj8FfgOzAh7ri6PM9gRoklPGnkJjsvogK1IIFmyyZgnvqNqfBGbxqxTjNdYJa8/b6SECJ+qwO8/tu35QbiWEQq/PNx/lMRatBPF+C+EcwoRrT1oNyTBAqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329361; c=relaxed/simple;
	bh=PQIJbn+HVkVdW1CrXT3F7vYzyUPwCyqhMqLvtFJAjQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOXiuFNyfJnG4+5g2kQxKfTGsJVjMneuWUc9xR9CTun5Fb2u+qFb+5F1XN59kMAoF1uh/8Pjd8yLi/BDA7AJZPMtPObqqezcSb1wAgi3NwSn3YGGEaKiDGYlGA6ldCbTeosoL1L8f0iPJK4gEPPGjG+pF9/jfvfoQyt3mPRXw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-a1-67ca93c9d7a2
From: Rakie Kim <rakie.kim@sk.com>
To: gourry@gourry.net
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: [PATCH 4/4] mm/mempolicy: Fix memory leaks in mempolicy_sysfs_init()
Date: Fri,  7 Mar 2025 15:35:33 +0900
Message-ID: <20250307063534.540-5-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250307063534.540-1-rakie.kim@sk.com>
References: <20250307063534.540-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsXC9ZZnke7JyafSDWbcNrCYs34Nm8X0qRcY
	LX7ePc5ucXzrPHaL87NOsVhc3jWHzeLemv+sFqvXZDhweOycdZfdo7vtMrvH4j0vmTw2fZrE
	7nFixm8Wj50PLT0+b5ILYI/isklJzcksSy3St0vgyti+r67gPn9F85bTLA2MB3m6GDk5JARM
	JLasWMMGY99eshnI5uBgE1CSOLY3BiQsIiAqMe/obJYuRi4OZoHFTBILD69nAqkRFvCV6G+0
	AKlhEVCV6Gi5CzaGV8BY4vy698wQIzUlGi7dYwKxOYHGH1/1iBGkVQio5u+uUohyQYmTM5+w
	gNjMAvISzVtnM4OskhA4wSbx9M4vJog5khIHV9xgmcDIPwtJzywkPQsYmVYxCmXmleUmZuaY
	6GVU5mVW6CXn525iBIbwsto/0TsYP10IPsQowMGoxMPrMfVkuhBrYllxZe4hRgkOZiURXsHN
	QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2MbiJv7jyv
	rz3UYZVQd15HbfWNz9c9uqQevA4yN7zDG/l5giPfGt5i+9YjlSuPte9mX8O8zJDBRfe7jVty
	s8C6vxfnTjS4fu/31yZVed7p3vMvxLxrdRd9p/X85O0raza4l99u2T1fsUjl260dE59eXHT+
	T/2hI7+ZzqZI/tfJ/vwmU2nlx0CmfUosxRmJhlrMRcWJABWCoTRdAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsXCNUNNS/fk5FPpBk0t2hZz1q9hs5g+9QKj
	xc+7x9ktPj97zWxxfOs8dovDc0+yWpyfdYrF4vKuOWwW99b8Z7U4dO05q8XqNRkWv7etYHPg
	8dg56y67R3fbZXaPxXteMnls+jSJ3ePEjN8sHjsfWnp8u+3hsfjFByaPz5vkAjijuGxSUnMy
	y1KL9O0SuDK276sruM9f0bzlNEsD40GeLkZODgkBE4nbSzazdTFycLAJKEkc2xsDEhYREJWY
	d3Q2SxcjFwezwGImiYWH1zOB1AgL+Er0N1qA1LAIqEp0tNxlA7F5BYwlzq97zwwxUlOi4dI9
	JhCbE2j88VWPGEFahYBq/u4qhSgXlDg58wkLiM0sIC/RvHU28wRGnllIUrOQpBYwMq1iFMnM
	K8tNzMwx1SvOzqjMy6zQS87P3cQIDNtltX8m7mD8ctn9EKMAB6MSD6/H1JPpQqyJZcWVuYcY
	JTiYlUR4BTcDhXhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODil
	GhgTZP79+PBdWMZISPPtocgc5fl3vTK4RL/Upc4TjqqZOvFvZl7nbYGk3Wd3mfv/uHR6WtZB
	7iO3ghiyV22dzetsYV9V/+hjydKah+nMc6N/ms3ifDG7/36pnudhuYOaRS+iVhwysN23YO7u
	kEOxjFxlKUsb6qIvubQf9Wlobl0ap9yxbhrz9blKLMUZiYZazEXFiQB+7MM3VwIAAA==
X-CFilter-Loop: Reflected

Improper cleanup of sysfs attributes caused kobject and memory leaks when
initialization failed or nodes were removed.

This patch ensures proper deallocation of kobjects and memory, preventing
resource leaks and improving stability.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
---
 mm/mempolicy.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2d19434c61ed..441a0635e81d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3604,47 +3604,47 @@ static int __init mempolicy_sysfs_init(void)
 	int err;
 	static struct kobject *mempolicy_kobj;
 
-	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
-	if (!mempolicy_kobj) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
 	ngrp = kzalloc(sizeof(*ngrp), GFP_KERNEL);
 	if (!ngrp) {
 		err = -ENOMEM;
-		goto mempol_out;
+		goto err_out;
 	}
 	mutex_init(&ngrp->kobj_lock);
 
 	ngrp->nattrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
-			     GFP_KERNEL);
+			       GFP_KERNEL);
 	if (!ngrp->nattrs) {
 		err = -ENOMEM;
 		goto ngrp_out;
 	}
 
+	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
+	if (!mempolicy_kobj) {
+		err = -ENOMEM;
+		goto nattr_out;
+	}
+
 	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
 				   "mempolicy");
-	if (err)
-		goto node_out;
+	if (err) {
+		kobject_put(mempolicy_kobj);
+		goto err_out;
+	}
 
 	err = add_weighted_interleave_group(mempolicy_kobj);
 	if (err) {
-		pr_err("mempolicy sysfs structure failed to initialize\n");
 		kobject_put(mempolicy_kobj);
-		return err;
+		goto err_out;
 	}
 
-	return err;
-node_out:
+	return 0;
+
+nattr_out:
 	kfree(ngrp->nattrs);
 ngrp_out:
 	kfree(ngrp);
-mempol_out:
-	kfree(mempolicy_kobj);
 err_out:
-	pr_err("failed to add mempolicy kobject to the system\n");
+	pr_err("mempolicy sysfs structure failed to initialize\n");
 	return err;
 }
 
-- 
2.34.1

